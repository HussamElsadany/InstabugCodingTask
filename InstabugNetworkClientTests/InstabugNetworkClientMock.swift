//
//  InstabugNetworkClientMock.swift
//  InstabugNetworkClientTests
//
//  Created by Hussam Elsadany on 18/06/2022.
//

@testable import InstabugNetworkClient

class MockNetWorkClient: NetworkClientProtocol {

    var mockData: Data!

    var allRequest = [RequestModel]()

    func get(_ url: URL, completionHandler: @escaping (Data?) -> Void) {
        completionHandler(mockData)
    }

    func post(_ url: URL, payload: Data?, completionHandler: @escaping (Data?) -> Void) {
        completionHandler(mockData)
    }

    func put(_ url: URL, payload: Data?, completionHandler: @escaping (Data?) -> Void) {
        completionHandler(mockData)
    }

    func delete(_ url: URL, completionHandler: @escaping (Data?) -> Void) {
        completionHandler(mockData)
    }

    func allNetworkRequests(_ completionHandler: @escaping (([RequestModel]) -> Void)) {
        completionHandler(allRequest)
    }
}
