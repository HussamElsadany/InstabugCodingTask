//
//  InstabugDataStorageTests.swift
//  InstabugNetworkClientTests
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import XCTest
import CoreData
@testable import InstabugNetworkClient


class InstabugDataStorageTests: XCTestCase {

    var coreDataStack: CoreDataStack!
    var dataStorage: DataStorage!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreDataStack = TestCoreDataStack()
        dataStorage = DataStorage(coreDataStack: coreDataStack)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeleteAllRequests() throws {

        var request = URLRequest(url: URL(string:"http://google.com")!)
        request.httpMethod = "GET"

        dataStorage.saveNewRequest(request, nil, nil, nil)

        dataStorage.getAllRequests { requests in
            XCTAssertEqual(requests.count, 1)

            self.dataStorage.removeAllRequests()

            self.dataStorage.getAllRequests { requests in
                XCTAssertEqual(requests.count, 0)
            }
        }
    }

    func testMaxLimitRcord() throws {
        var request1 = URLRequest(url: URL(string:"http://google.com")!)
        request1.httpMethod = "GET"

        var request2 = URLRequest(url: URL(string:"http://google.com")!)
        request2.httpMethod = "GET"

        dataStorage.saveNewRequest(request1, nil, nil, nil)
        dataStorage.saveNewRequest(request2, nil, nil, nil)

        dataStorage.getAllRequests { requests in
            XCTAssertTrue(self.dataStorage.checkLimitRecorded(requests: requests, maxLimit: 2))
        }
    }
}
