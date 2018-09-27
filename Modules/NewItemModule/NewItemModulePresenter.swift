//
//  NewItemPresenter.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import CoreData

class NewItemModulePresenter: NewItemModulePresenterProtocol {
    
    func ConfirmButtonClicked() {
        let itemData = view?.GetItemData()
        var usedBy = [Person]()
        for person in (itemData?.usedBy.keys)!{
            if(itemData?.usedBy[person])!{
                usedBy.append(person)
            }
        }
        
        item?.setValue(itemData?.name, forKey: "name")
        item?.setValue(itemData?.cost, forKey: "cost")
        item?.setValue(itemData?.buyer, forKey: "buyer")
        item?.setValue(NSSet(array: usedBy), forKey: "usedBy")
        
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
        var message: String
        switch error {
        case ItemAdditionError.InvalidPriceFormat:
            message = "Invalid price format"
        case ItemAdditionError.NegativePrice:
            message = "Price has to be positive number"
        case ItemAdditionError.NoNameEntered:
            message = "Enter item name"
        case ItemAdditionError.NoPersonUsingItem:
            message = "Atleast one person have to be using this item"
        default:
            message = ""
        }
        view?.SetMessageLabel(message: message)
    }
    
    func AddButtonClicked() {
        let itemData = view?.GetItemData()
        var usedBy = [Person]()
        for person in (itemData?.usedBy.keys)!{
            if(itemData?.usedBy[person])!{
                usedBy.append(person)
            }
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: (dataController?.managedObjectContext)!)
        let record = NSManagedObject(entity: entity!, insertInto: dataController?.managedObjectContext)
        
        record.setValue(itemData?.name, forKey: "name")
        record.setValue(itemData?.cost, forKey: "cost")
        record.setValue(itemData?.buyer, forKey: "buyer")
        record.setValue(NSSet(array: usedBy), forKey: "usedBy")
        
        do {
            try dataController?.managedObjectContext.save()
        } catch let error as NSError {
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
