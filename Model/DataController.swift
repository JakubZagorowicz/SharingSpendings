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
    func AddEntity<T: EntityDataProtocol>(entityData: T) throws
    func UpdateEntity<T: EntityDataProtocol, Y:NSManagedObject>(entityData:T, entity:Y) throws
    func DeleteEntity<T:NSManagedObject>(entity:T) throws
}

class DataController: NSObject {

    var dataModelName: String
    
    init(dataModelName: String){
        self.dataModelName = dataModelName
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
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
}

extension DataController: DataControllerProtocol{
    func AddEntity<T>(entityData: T) throws where T : EntityDataProtocol {
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
            try SaveContext()
        }
        catch let error as NSError{
            throw error
        }
    }
    
    func UpdateEntity<T: EntityDataProtocol,Y: NSManagedObject>(entityData: T, entity: Y) throws{
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
            try SaveContext()
        }
        catch let error as NSError{
            throw error
        }
    }
    
    func DeleteEntity<T>(entity: T) throws where T : NSManagedObject {
        managedObjectContext.delete(entity)
        do {
            try SaveContext()
        }
        catch let error as NSError{
            throw error
        }
    }
    
    func SaveContext() throws{
        do {
            try managedObjectContext.save()
        }
        catch let error as NSError{
            throw error
        }
    }
}
