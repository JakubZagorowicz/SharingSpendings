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
            if meeting?.status == "active" || meeting?.status == nil{
                view?.toggleToEditMode()
            }
            else{
                view?.toggleToClosedMode()
            }
        }
    }
    
    func invalidInput(error: itemAdditionError){
        view?.showAdditionErrorPopUp(with: error.GetErrorMessage())
    }
    
    func addButtonClicked() {
        let itemData = view?.getItemData()

        do{
          try DataController.entityManager.addEntity(entityData: itemData!)
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        router?.back()
    }
    
    func confirmButtonClicked() {
        let itemData = view?.getItemData()
        
        do{
            try DataController.entityManager.updateEntity(entityData: itemData!, entity: item!)
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
