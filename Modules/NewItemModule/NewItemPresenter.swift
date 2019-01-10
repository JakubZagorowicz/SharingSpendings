//
//  NewItemPresenter.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
//import CoreData

class NewItemPresenter: NewItemPresenterProtocol {
    var view: NewItemViewControllerProtocol?
    var router: BackableProtocol?
    var meeting: Meeting?
    
    var item: Item?
    
    func viewWillAppear() {
        view?.setPeopleData(people: Array(meeting!.peopleAttending!) as! [Person])
        if(item != nil){
            view?.fillWithItemData(item: item!)
            view?.switchButtons()
            view?.setTitle(title: "Edit item")
        }
    }
    
    func invalidInput(error: itemAdditionError){
        view?.showAdditionErrorPopUp(with: error.GetErrorMessage())
    }
    
    func addButtonClicked() {
        let itemData = view?.getItemData()

        do{
          try DataManager.dataManager.dataController.addEntity(entityData: itemData!)
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        router?.back()
    }
    
    func confirmButtonClicked() {
        let itemData = view?.getItemData()
        
        do{
            try DataManager.dataManager.dataController.updateEntity(entityData: itemData!, entity: item!)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        router?.back()
    }
    
    func backButtonClicked() {
        router?.back()
    }
}
