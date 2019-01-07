//
//  MeetingsManagmentModulePresenter.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class MeetingManagementModulePresenter : MeetingManagementModulePresenterProtcol{
    func CloseEventButtonClicked() {
        
    }
    
    func SetPresentedSection(toIndex: Int) {
        presentedSection = toIndex
    }
    
    func AddButtonClicked() {
        if(presentedSection == 0){
            router?.NewPersonClicked(meeting: meeting!)
        }
        else{
            router?.NewItemButtonClicked(meeting: meeting!)
        }
    }
    
    func PeopleButtonClicked() {
        view?.ScrollToSection(index: 0)
    }
    
    func ItemsButtonClicked() {
        view?.ScrollToSection(index: 1)
    }
    
    func SettlementButtonClicked() {
        view?.ScrollToSection(index: 2)
    }
    
    var presentedSection: Int = 0 {
        didSet{
            if presentedSection == 2{
                view?.AddButtonIsVisible(isVisible: false)
            }
            else{
                view?.AddButtonIsVisible(isVisible: true)
                view?.SetAddItemButton(isEnabled: !(people?.count == 0 && presentedSection == 1))
            }
        }
    }
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
        
//        if(meeting?.peopleAttending?.count == 0){
//            view?.SetAddItemButton(isEnabled: false)
//        }
//        else{
//            view?.SetAddItemButton(isEnabled: true)
//        }
        var doesAnyDebtExist = false
        for tuple in people!{
            if tuple.1 != 0{
                doesAnyDebtExist = true
            }
        }
        if doesAnyDebtExist{
            view?.SetDebtsData(debts: (meeting?.CalculateDebts(balances: people!))!)
        }
        else{
            view?.SetDebtsData(debts: [Debt]())
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
//                view?.SetMessageLabel(message: "Can't delete person, who is the only user of \(blockingItem.name!), and didn't pay for it.")
                view?.ShowPopUp(_with: "Can't delete person, who is the only user of \(blockingItem.name!), and didn't pay for it.")
            }
        }
        else{
//            view?.SetMessageLabel(message: "Can't delete person that paid for items.")
            view?.ShowPopUp(_with: "Can't delete person that paid for items.")
        }
    }
    
    var view: MeetingManagementModuleViewControllerProtocol?
    var router: (MeetingManagementRoutingProtocol & BackableProtocol)?
    var meeting: Meeting?
    var people: [(Person,Double)]?
    
}
