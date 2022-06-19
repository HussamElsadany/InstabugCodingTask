//
//  InstabugNetworkClientTests.swift
//  InstabugNetworkClientTests
//
//  Created by Yousef Hamza on 1/13/21.
//

import XCTest
@testable import InstabugNetworkClient

class InstabugNetworkClientTests: XCTestCase {

    var mockClient: MockNetWorkClient!

    var coreDataStack: CoreDataStack!
    var dataStorage: DataStorage!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockClient = MockNetWorkClient()
        NetworkClient.shared = mockClient

        coreDataStack = TestCoreDataStack()
        dataStorage = DataStorage(coreDataStack: coreDataStack)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetRequest() throws {
        let url = URL(string: "https://google.com")!

        let string = "Test Get Request"
        let data = string.data(using: .utf8)
        mockClient.mockData = data

        NetworkClient.shared.get(url) { responseData in
            XCTAssertEqual(data, responseData)
        }
    }

    func testAllRequest() throws {
        mockClient.allRequest = [RequestModel(), RequestModel()]
        NetworkClient.shared.allNetworkRequests { requeests in
            XCTAssertEqual(requeests.count, 2)
        }
    }
}
