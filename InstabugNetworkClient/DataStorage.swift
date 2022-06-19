//
//  DataStorage.swift
//  InstabugNetworkClient
//
//  Created by Hussam Elsadany on 17/06/2022.
//

import Foundation
import CoreData

fileprivate let MaxRequestsCount = 1000
fileprivate let MaxPayloadSize = 1000000 // in bytes

protocol DataStorageProtocol: AnyObject {
    func saveNewRequest(_ request: URLRequest, _ response: URLResponse?, _ data: Data?, _ error: Error?)
    func getAllRequests(_ completionHandler: @escaping (([RequestModel]) -> Void))
    func removeAllRequests()
    func checkLimitRecorded(requests: [RequestModel], maxLimit: Int) -> Bool
}

class DataStorage {

    let coreDataStack: CoreDataStack
    
    private let semaphore = DispatchSemaphore(value: 1)

    init (coreDataStack: CoreDataStack) {
        self.coreDataStack = CoreDataStack()
        removeAllRequests()
    }
}

extension DataStorage: DataStorageProtocol {

    func saveNewRequest(_ request: URLRequest, _ response: URLResponse?, _ data: Data?, _ error: Error?) {

        coreDataStack.performBackgroundTask { context in
            self.semaphore.wait()

            let allRequests = try! context.fetch(RequestModel.fetchRequest())
            if self.checkLimitRecorded(requests: allRequests, maxLimit: MaxRequestsCount) {
                self.deleteFirstItem(allRequests: allRequests, context: context)
            }

            let newRequest = RequestModel(context: context)
            newRequest.url = request.url?.absoluteString
            newRequest.method = request.httpMethod
            newRequest.payload = self.checkDataSizeLimit(data: request.httpBody)
            newRequest.response = self.generateResponse(response: response,
                                                        data: data,
                                                        error: error,
                                                        context: context)
            self.saveData(context: context)
            self.semaphore.signal()
        }
    }

    func getAllRequests(_ completionHandler: @escaping (([RequestModel]) -> Void)) {
        coreDataStack.performBackgroundTask { context in
            self.semaphore.wait()
            let allRequests = try! context.fetch(RequestModel.fetchRequest())
            completionHandler(allRequests)
            self.semaphore.signal()
        }
    }

    func removeAllRequests() {
        coreDataStack.performBackgroundTask { context in
            self.semaphore.wait()
            let allRequests = try! context.fetch(RequestModel.fetchRequest())
            for request in allRequests {
                context.delete(request)
            }
            self.saveData(context: context)
            self.semaphore.signal()
        }
    }

    func checkLimitRecorded(requests: [RequestModel], maxLimit: Int) -> Bool {
        return requests.count == maxLimit
    }
}

private extension DataStorage {

    // MARK: Helper Functions
    func generateResponse(response: URLResponse?, data: Data?, error: Error?, context: NSManagedObjectContext) -> ResponseModel? {
        let newResponse = ResponseModel(context: context)

        if let error = error as? NSError {
            newResponse.error = generate(error: error, context: context)
            return newResponse
        }

        if let response = response as? HTTPURLResponse, let data = data {
            newResponse.success = generateSuccess(data: data, statusCode: response.statusCode, context: context)
        }
        return newResponse
    }

    func generate(error: NSError, context: NSManagedObjectContext) -> ErrorModel {
        let newError = ErrorModel(context: context)
        newError.code = Int64(error.code)
        newError.domain = error.domain
        return newError
    }

    func generateSuccess(data: Data, statusCode: Int, context: NSManagedObjectContext) -> SuccessModel {
        let newSuccess = SuccessModel(context: context)
        newSuccess.code = Int64(statusCode)
        newSuccess.payload = checkDataSizeLimit(data: data)
        return newSuccess
    }

    func saveData(context: NSManagedObjectContext) {
        do {
            try? context.save()
        }
    }

    func deleteFirstItem(allRequests: [RequestModel], context: NSManagedObjectContext) {
        if let request = allRequests.first {
            context.delete(request)
            self.saveData(context: context)
        }
    }

    func checkDataSizeLimit(data: Data?) -> Data? {
        guard let data = data else {
            return nil
        }

        if data.count > MaxPayloadSize {
            let string = "payload too large"
            return string.data(using: .utf8)
        }

        return data
    }
}
