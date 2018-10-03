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
    var router: Mothership?
    var dataController: DataController?
    
    var people: [Person]?
    var item: Item?
    
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

        do{
          try dataController?.AddEntity(entityData: itemData!)
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        router?.GoBack()
    }
    
    func ConfirmButtonClicked() {
        let itemData = view?.GetItemData()
        
        do{
            try dataController?.UpdateEntity(entityData: itemData!, entity: item!)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
            
        }
        router?.GoBack()
    }
    func BackButtonClicked() {
        router?.GoBack()
    }

}
