//
//  CoreDataStack.swift
//  InstabugNetworkClient
//
//  Created by Hussam Elsadany on 17/06/2022.
//

import CoreData

fileprivate let DataStorgeName = "InstabugNetworkClient"

final class PersistentContainer: NSPersistentContainer { }

class CoreDataStack {
    
    public var persistentContainer: NSPersistentContainer!

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    init() {
        prepare()
    }

    func performBackgroundTask(block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }

    func prepare() {
        let bundle = Bundle(for: type(of: self))
        let model = NSManagedObjectModel.mergedModel(from: [bundle])!
        persistentContainer = PersistentContainer(name: DataStorgeName, managedObjectModel: model)
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
                fatalError()
            }
        }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
    }

    func saveContext() {
        do {
            if persistentContainer.viewContext.hasChanges {
                try persistentContainer.viewContext.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
