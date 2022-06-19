//
//  NetworkClient.swift
//  InstabugNetworkClient
//
//  Created by Yousef Hamza on 1/13/21.
//

import Foundation

public protocol NetworkClientProtocol {
    func get(_ url: URL, completionHandler: @escaping (Data?) -> Void)
    func post(_ url: URL, payload: Data?, completionHandler: @escaping (Data?) -> Void)
    func put(_ url: URL, payload: Data?, completionHandler: @escaping (Data?) -> Void)
    func delete(_ url: URL, completionHandler: @escaping (Data?) -> Void)
    func allNetworkRequests(_ completionHandler: @escaping (([RequestModel]) -> Void))
}

public class NetworkClient: NetworkClientProtocol {

    private var dataStorage: DataStorageProtocol!

#if TEST
    public static var shared: NetworkClientProtocol!
    public init() { }
#else
    public static var shared: NetworkClientProtocol = NetworkClient()
    private init() {
        let coreDataStack = CoreDataStack()
        dataStorage = DataStorage(coreDataStack: coreDataStack)
    }
#endif

    // MARK: Network requests
    public func get(_ url: URL, completionHandler: @escaping (Data?) -> Void) {
        executeRequest(url, method: "GET", payload: nil, completionHandler: completionHandler)
    }

    public func post(_ url: URL, payload: Data?=nil, completionHandler: @escaping (Data?) -> Void) {
        executeRequest(url, method: "POST", payload: payload, completionHandler: completionHandler)
    }

    public func put(_ url: URL, payload: Data?=nil, completionHandler: @escaping (Data?) -> Void) {
        executeRequest(url, method: "PUT", payload: payload, completionHandler: completionHandler)
    }

    public func delete(_ url: URL, completionHandler: @escaping (Data?) -> Void) {
        executeRequest(url, method: "DELETE", payload: nil, completionHandler: completionHandler)
    }

    func executeRequest(_ url: URL, method: String, payload: Data?, completionHandler: @escaping (Data?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = payload
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            self.dataStorage.saveNewRequest(urlRequest, response, data, error)

            DispatchQueue.main.async {
                completionHandler(data)
            }

        }.resume()
    }

    // MARK: Network recording
    public func allNetworkRequests(_ completionHandler: @escaping (([RequestModel]) -> Void)) {
        dataStorage.getAllRequests { requests in
            completionHandler(requests)
        }
    }
}
