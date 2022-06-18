//
//  DataStorage.swift
//  InstabugNetworkClient
//
//  Created by Hussam Elsadany on 17/06/2022.
//

import Foundation
import CoreData

fileprivate let MaxRequestsCount = 4

protocol DataStorageLogic: AnyObject {
    func saveNewRequest(_ request: URLRequest, _ response: URLResponse?, _ data: Data?, _ error: Error?)
    func getAllRequests(_ completionHandler: @escaping (([RequestModel]) -> Void))
    func removeAllRequests()
}

class DataStorage {
    init () {
        removeAllRequests()
    }
    private let semaphore = DispatchSemaphore(value: 1)
}

extension DataStorage: DataStorageLogic {

    func saveNewRequest(_ request: URLRequest, _ response: URLResponse?, _ data: Data?, _ error: Error?) {

        CoreDataStack.shared.performBackgroundTask { context in
            self.semaphore.wait()
            self.checkForMaxSavedItems(context: context)

            let newRequest = RequestModel(context: context)
            newRequest.url = request.url?.absoluteString
            newRequest.method = request.httpMethod
            newRequest.payload = request.httpBody
            newRequest.response = self.generateResponse(response: response,
                                                        data: data,
                                                        error: error,
                                                        context: context)
            self.saveData(context: context)
            self.semaphore.signal()
        }
    }

    func getAllRequests(_ completionHandler: @escaping (([RequestModel]) -> Void)) {
        CoreDataStack.shared.performBackgroundTask { context in
            self.semaphore.wait()
            let allRequests = try! context.fetch(RequestModel.fetchRequest())
            completionHandler(allRequests)
            self.semaphore.signal()
        }
    }

    func removeAllRequests() {
        CoreDataStack.shared.performBackgroundTask { context in
            self.semaphore.wait()
            let allRequests = try! context.fetch(RequestModel.fetchRequest())
            for request in allRequests {
                context.delete(request)
            }
            self.saveData(context: context)
            self.semaphore.signal()
        }
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
        newSuccess.payload = data
        return newSuccess
    }

    func saveData(context: NSManagedObjectContext) {
        do {
            try? context.save()
        }
    }

    func checkForMaxSavedItems(context: NSManagedObjectContext) {
        getAllRequests { requests in
            if requests.count == MaxRequestsCount {
                if let request = requests.first {
                    context.delete(request)
                }
            }
            self.saveData(context: context)
        }
    }
}
