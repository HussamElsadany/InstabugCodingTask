//
//  TestCoreDataStack.swift
//  InstabugNetworkClientTests
//
//  Created by Hussam Elsadany on 18/06/2022.
//

import CoreData
@testable import InstabugNetworkClient

fileprivate let DataStorgeName = "InstabugNetworkClient"

class TestCoreDataStack: CoreDataStack {

    lazy var managedObjectModel: NSManagedObjectModel = {
        let frameworkBundleIdentifier = "com.Instabug.InstabugNetworkClient"
        let customBundle = Bundle(identifier: frameworkBundleIdentifier)!
        let modelURL = customBundle.url(forResource: DataStorgeName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    override init() {

        super.init()

        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(
          name: DataStorgeName,
          managedObjectModel: managedObjectModel)
        container.persistentStoreDescriptions = [persistentStoreDescription]

        container.loadPersistentStores { _, error in
          if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
        }

        persistentContainer = container
    }
}
