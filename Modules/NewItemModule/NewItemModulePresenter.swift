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
    
    var view: NewItemModuleViewControllerProtocol?
    var router: BackableProtocol?
    var meeting: Meeting?
    
  //  var people: [Person]?
    var item: Item?
    
    func ViewWillAppear() {
        view?.SetPeopleData(people: Array(meeting!.peopleAttending!) as! [Person])
        if(item != nil){
            view?.FillWithItemData(item: item!)
            view?.SwitchButtons()
            view?.SetTitle(title: "Edit item")
        }
    }
    
    func InvalidInput(error: ItemAdditionError){
//        view?.SetMessageLabel(message: error.GetErrorMessage())
        view?.ShowPopUp(_with: error.GetErrorMessage())
    }
    
    func AddButtonClicked() {
        let itemData = view?.GetItemData()

        do{
          try DataManager.dataManager.dataController.AddEntity(entityData: itemData!)
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        router?.Back()
    }
    
    func ConfirmButtonClicked() {
        let itemData = view?.GetItemData()
        
        do{
            try DataManager.dataManager.dataController.UpdateEntity(entityData: itemData!, entity: item!)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
            
        }
        router?.Back()
    }
    func BackButtonClicked() {
        router?.Back()
    }

}
