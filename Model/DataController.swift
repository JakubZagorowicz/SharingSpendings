//
//  PaymentService.swift
//  SharingSpendings
//
//  Created by User on 30.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import CoreData

protocol DataControllerProtocol {
    func addEntity<T: EntityDataProtocol>(entityData: T) throws
    func updateEntity<T: EntityDataProtocol, Y:NSManagedObject>(entityData:T, entity:Y) throws
    func deleteEntity<T:NSManagedObject>(entity:T) throws
}

class DataController: NSObject {
    static let entityManager = DataController()
    var dataModelName: String
    
    private override init(){
        self.dataModelName = "DataModel"
    }
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.dataModelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.dataModelName).sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        
        do {
            let options = [ NSInferMappingModelAutomaticallyOption : true,
                            NSMigratePersistentStoresAutomaticallyOption : true]
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: options)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
}

extension DataController: DataControllerProtocol{
    func addEntity<T>(entityData: T) throws where T : EntityDataProtocol {
        let record = NSManagedObject(entity: NSEntityDescription.entity(forEntityName: entityData.entityName, in: managedObjectContext)!, insertInto: managedObjectContext)
        
        for tuple in entityData.attributes{
            if let att = tuple.1 as? NSArray {
                let set = NSSet(array: att as! [Any])
                record.setValue(set, forKey: tuple.0)
            }
            else{
                record.setValue(tuple.1, forKey: tuple.0)
            }
        }
        do {
            try saveContext()
        }
        catch let error as NSError{
            throw error
        }
    }
    
    func updateEntity<T: EntityDataProtocol,Y: NSManagedObject>(entityData: T, entity: Y) throws{
        for tuple in entityData.attributes{
            if let att = tuple.1 as? NSArray {
                let set = NSSet(array: att as! [Any])
                entity.setValue(set, forKey: tuple.0)
            }
            else{
                entity.setValue(tuple.1, forKey: tuple.0)
            }
        }
        do {
            try saveContext()
        }
        catch let error as NSError{
            throw error
        }
    }
    
    func deleteEntity<T>(entity: T) throws where T : NSManagedObject {
        managedObjectContext.delete(entity)
        do {
            try saveContext()
        }
        catch let error as NSError{
            throw error
        }
    }
    
    func saveContext() throws{
        do {
            try managedObjectContext.save()
        }
        catch let error as NSError{
            throw error
        }
    }
}
