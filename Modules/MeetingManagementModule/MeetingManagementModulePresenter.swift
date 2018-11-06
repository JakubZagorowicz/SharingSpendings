//
//  MeetingsManagmentModulePresenter.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class MeetingManagementModulePresenter : MeetingManagementModulePresenterProtcol{
    func ViewWillAppear() {        
        
        if(meeting?.peopleAttending == nil){
            meeting?.peopleAttending = NSSet()
        }
        var items = [Item]()
    //  people = (Array((meeting?.peopleAttending)!) as! [Person])
        people = meeting?.CalculateBalance()
        for person in people! {
            for item in person.0.itemsBought!{
                items.append(item as! Item)
            }
        }
        view?.SetTableData(people: people!, items: items)
    }
    
    func SettleUpButtonClicked() {
        router?.GoToMeetingSettlementModule(dataController: dataController!, meeting: meeting!)
    }
    
    func BackButtonClicked(){
        router?.GoBack()
    }
    
    func ItemClicked(item: Item) {
        router?.GoToNewItemModule(dataController: dataController!, people: Array(meeting!.peopleAttending!) as! [Person], item: item, meeting: meeting!)
    }
    
    func PersonClicked(person: Person) {
        router?.GoToNewPersonModule(dataController: dataController!, person: person, meeting: meeting!)
    }
    
    func AddPersonClicked() {
        router?.GoToNewPersonModule(dataController: dataController!, meeting: meeting!)
    }
    
    func AddItemClicked() {
        let people = Array(meeting!.peopleAttending!) as! [Person]
        router?.GoToNewItemModule(dataController: dataController!, people: people, meeting: meeting!)
    }
    
    func DeleteItemClicked(item: Item) {
        do {
            try dataController?.DeleteEntity(entity: item)
            
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
                    try dataController?.DeleteEntity(entity: person)
                    
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
    
    func CalculateSpendings(){
//        if((people?.count)! > 0){
//        for index in 0...(people?.count)!-1 {
//            var balance : Double = 0
//            for item in (people?[index].itemsBought)! {
//                let item = item as! Item
//                balance += item.cost
//            }
//            for item in (people?[index].itemsUsed)!{
//                let item = item as! Item
//                balance -= item.cost/Double((item.usedBy?.count)!)
//            }
//            view?.SetBalance(for: index, balance: balance)
//            }
//        }
    }
    
    
    var view: MeetingManagementModuleViewControllerProtocol?
    var router: Mothership?
    var meeting: Meeting?
    var people: [(Person,Double)]?
    
    var dataController: DataController?
}
