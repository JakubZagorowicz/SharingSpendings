//
//  MeetingsManagmentModulePresenter.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class MeetingManagementModulePresenter : MeetingManagementModulePresenterProtcol{
    var items = [Item]()

    func ViewWillAppear() {
        view?.SetMeetingName(name: (meeting?.name)!)
        if(meeting?.peopleAttending == nil){
            meeting?.peopleAttending = NSSet()
        }
        items = [Item]()
        people = meeting?.CalculateBalance()
        for person in people! {
            for item in person.0.itemsBought!{
                items.append(item as! Item)
            }
        }
        
        if(meeting?.peopleAttending?.count == 0){
            view?.SetAddItemButton(isEnabled: false)
        }
        else{
            view?.SetAddItemButton(isEnabled: true)
        }
        var doesAnyDebtExist = false
        for tuple in people!{
            if tuple.1 != 0{
                doesAnyDebtExist = true
            }
        }
        
        if((meeting?.peopleAttending?.count)! > 1 && items.count > 0 && doesAnyDebtExist){
            view?.SetSettleUpButton(isEnabled: true)
        }
        else{
            view?.SetSettleUpButton(isEnabled: false)
        }
        
        view?.SetTableData(people: people!, items: items)
    }
    
    func SettleUpButtonClicked() {
        router?.SettleUpButtonClicked(meeting: meeting!)
    }
    
    func BackButtonClicked(){
        router?.Back()
    }
    
    func ItemClicked(item: Item) {
        router?.ItemClicked(item: item, meeting: meeting!)
    }
    
    func PersonClicked(person: Person) {
        router?.PersonClicked(person: person, meeting: meeting!)
    }
    
    func AddPersonClicked() {
        router?.NewPersonClicked(meeting: meeting!)
    }
    
    func AddItemClicked() {
        router?.NewItemButtonClicked(meeting: meeting!)
    }
    
    func DeleteItemClicked(item: Item) {
        do {
            try DataManager.dataManager.dataController.DeleteEntity(entity: item)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        ViewWillAppear()
    }
    
    func DeletePersonClicked(person: Person) {
        if(person.itemsBought?.count == 0){
            var personCanBeDeleted = true
            var blockingItem: Item = Item()
            for item in person.itemsUsed!{
                let item = item as! Item
                if (item.usedBy?.count == 1 && item.buyer != person){
                    personCanBeDeleted = false
                    blockingItem = item
                }
            }
            if(personCanBeDeleted){
                do {
                    try DataManager.dataManager.dataController.DeleteEntity(entity: person)
                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                ViewWillAppear()
            }
            else{
                view?.SetMessageLabel(message: "Can't delete person, who is the only user of \(blockingItem.name!), and didn't pay for it.")
            }
        }
        else{
            view?.SetMessageLabel(message: "Can't delete person that paid for items.")
        }
    }
    
    var view: MeetingManagementModuleViewControllerProtocol?
    var router: (MeetingManagementRoutingProtocol & BackableProtocol)?
    var meeting: Meeting?
    var people: [(Person,Double)]?
    
}
