//
//  MeetingsManagmentModulePresenter.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class MeetingManagementPresenter : MeetingManagementPresenterProtcol{

    var items = [Item]()
    var view: MeetingManagementViewControllerProtocol?
    var router: (MeetingManagementRoutingProtocol & BackableProtocol)?
    var meeting: Meeting?
    var people: [(Person,Double)]?
    var lastDebtClicked: Int?
    var debts: [Debt]?
    
    func closeEventButtonClicked() {
        view?.askForEventClosureConfirmation()
    }
    
    func closeEventConfirmed() {
        meeting?.status = "closed"
        meeting?.debtsSettled = [Bool](repeating: false, count: debts!.count) as NSObject
        do{
            try DataController.entityManager.saveContext()
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func setPresentedSection(toIndex: Int) {
        presentedSection = toIndex
    }
    
    func addButtonClicked() {
        if(presentedSection == 0){
            router?.newPersonClicked(meeting: meeting!)
        }
        else{
            router?.newItemButtonClicked(meeting: meeting!)
        }
    }
    
    func peopleButtonClicked() {
        view?.scrollToSection(index: 0)
    }
    
    func itemsButtonClicked() {
        view?.scrollToSection(index: 1)
    }
    
    func settlementButtonClicked() {
        view?.scrollToSection(index: 2)
    }
    
    var presentedSection: Int = 0 {
        didSet{
            if presentedSection == 2 || meeting?.status == "closed" || meeting?.status == "settled"{
                view?.addButtonIsVisible(isVisible: false)
            }
            else{
                view?.addButtonIsVisible(isVisible: true)
                view?.setAddItemButton(isEnabled: !(people?.count == 0 && presentedSection == 1))
            }
        }
    }


    func viewWillAppear() {
        view?.setMeetingName(name: (meeting?.name)!)
        if(meeting?.peopleAttending == nil){
            meeting?.peopleAttending = NSSet()
        }
        items = [Item]()
        people = meeting?.calculateBalance()
        for person in people! {
            for item in person.0.itemsBought!{
                items.append(item as! Item)
            }
        }

        var doesAnyDebtExist = false
        for tuple in people!{
            if tuple.1 != 0{
                doesAnyDebtExist = true
            }
        }
        if doesAnyDebtExist{
            debts = meeting?.calculateDebts(balances: people!)
            view?.setDebtsData(debts: debts!)
        }
        else{
            view?.setDebtsData(debts: [Debt]())
        }
        if meeting?.status == "closed" || meeting?.status == "settled"{
            view?.toggleToClosedMode()
        }
        view?.setTableData(people: people!, items: items)
    }
    
    func cellLongPress(section: Int, row: Int) {
        let options: [SelectableOptions]
        switch section {
        case 0:
            options = (meeting?.status == "active" || meeting?.status == nil) ? [.edit, .delete] : []
        case 1:
            options = (meeting?.status == "active" || meeting?.status == nil) ? [.edit, .delete] : []
        default:
            options = []
        }
        if options.count != 0{
            view?.presentOptions(options: options)
        }
        
    }
    
    func settleUpButtonClicked() {
        router?.settleUpButtonClicked(meeting: meeting!)
    }
    
    func backButtonClicked(){
        router?.back()
    }
    
    func itemClicked(item: Item) {
        router?.itemClicked(item: item, meeting: meeting!)
    }
    
    func personClicked(person: Person) {
        router?.personClicked(person: person, meeting: meeting!)
    }
    
    func debtClicked(at index: Int){
        lastDebtClicked = index
        view?.askForDebtSettlementConfirmation()
    }
    
    func debtSettlementConfirmed(){
        var debtsArray = meeting?.debtsSettled as! [Bool]
        debtsArray[lastDebtClicked!] = true
        meeting?.debtsSettled = debtsArray as NSObject
        do{
            try DataController.entityManager.saveContext()
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func addPersonClicked() {
        router?.newPersonClicked(meeting: meeting!)
    }
    
    func addItemClicked() {
        router?.newItemButtonClicked(meeting: meeting!)
    }
    
    func deleteItemClicked(item: Item) {
        do {
            try DataController.entityManager.deleteEntity(entity: item)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        viewWillAppear()
    }
    
    func deletePersonClicked(person: Person) {
        if(person.itemsBought?.count == 0){
            let deleteabillityCheck = checkIfDeleteable(person: person)
            if(deleteabillityCheck.0){
                do {
                    try DataController.entityManager.deleteEntity(entity: person)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                viewWillAppear()
            }
            else{
                view?.showMessagePopUp(message: "Can't delete person, who is the only user of \(deleteabillityCheck.1!.name!), and didn't pay for it.")
            }
        }
        else{
            view?.showMessagePopUp(message: "Can't delete person that paid for items.")
        }
    }
    
    func checkIfDeleteable(person: Person) -> (Bool, Item?){
        for item in person.itemsUsed!{
            let item = item as! Item
            if (item.usedBy?.count == 1 && item.buyer != person){
                return (false, item)
            }
        }
        return (true, nil)
    }
}
