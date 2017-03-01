//
//  CoreDataManager.swift
//  CoreDataHelloWorld
//
//  Created by Diego Freniche Brito on 15/2/17.
//  Copyright © 2017 freniche. All rights reserved.
//

import CoreData

public class CoreDataManager {
    public func persistentContainer(dbName: String) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: dbName)

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    public func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
