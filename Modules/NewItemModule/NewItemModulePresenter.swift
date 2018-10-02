//
//  NewItemPresenter.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
//import CoreData

class NewItemModulePresenter: NewItemModulePresenterProtocol {
    
    func ConfirmButtonClicked() {
        let itemData = view?.GetItemData()
        
//        item?.setValue(itemData?.name, forKey: "name")
//        item?.setValue(itemData?.cost, forKey: "cost")
//        item?.setValue(itemData?.buyer, forKey: "buyer")
//        item?.setValue(NSSet(array: (itemData?.usedBy)!), forKey: "usedBy")
        do{
            try dataController?.UpdateEntity(entityData: itemData!, entity: item!)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")

        }
        router?.GoBack()
    }
    
    func ViewWillAppear() {
        view?.SetPeopleData(people: people!)
        if(item != nil){
            view?.FillWithItemData(item: item!)
            view?.SwitchButtons()
        }
    }
    
    func InvalidInput(error: ItemAdditionError){
        view?.SetMessageLabel(message: error.GetErrorMessage())
    }
    
    func AddButtonClicked() {
        let itemData = view?.GetItemData()
//        var usedBy = [Person]()
//        for person in (itemData?.usedBy.keys)!{
//            if(itemData?.usedBy[person])!{
//                usedBy.append(person)
//            }
//        }
        
//        let entity = NSEntityDescription.entity(forEntityName: "Item", in: (dataController?.managedObjectContext)!)
//        let record = NSManagedObject(entity: entity!, insertInto: dataController?.managedObjectContext)
//
//        record.setValue(itemData?.name, forKey: "name")
//        record.setValue(itemData?.cost, forKey: "cost")
//        record.setValue(itemData?.buyer, forKey: "buyer")
//        record.setValue(NSSet(array: (itemData?.usedBy)!), forKey: "usedBy")
//
//        do {
//            try dataController?.managedObjectContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
        do{
          try dataController?.AddEntity(entityData: itemData!)
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        router?.GoBack()
    }
    
    func BackButtonClicked() {
        router?.GoBack()
    }
    
    var view: NewItemModuleViewControllerProtocol?
    var router: Mothership?
    var dataController: DataController?
    
    var people: [Person]?
    var item: Item?
}
