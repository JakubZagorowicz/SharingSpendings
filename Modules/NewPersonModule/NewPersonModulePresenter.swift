//
//  NewPersonPresenter.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class NewPersonModulePresenter : NewPersonModulePresenterProtocol {
    
    var view: NewPersonModuleViewControllerProtocol?
    var router: BackableProtocol?
    var meeting: Meeting?
    var person: Person?
    
    func ViewWillAppear() {
        if person != nil{
            view?.ShowPersonDetails(person: person!)
            view?.SwitchButtons()
            view?.SetTitle(title: "Edit person")
        }
    }
    
    func AddButtonClicked() {
        let name = view?.GetTextFieldData()

        do{
            let personData = PersonData(name: name!, meeting: meeting!)
            try DataManager.dataManager.dataController.AddEntity(entityData: personData)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        router?.Back()
    }
    
    func BackButtonClicked() {
        router?.Back()
    }
    
    func ConfirmButtonClicked() {
        let name = view?.GetTextFieldData()
        do{
            try DataManager.dataManager.dataController.UpdateEntity(entityData: PersonData(name: name!, meeting: meeting!), entity: person!)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        router?.Back()
    }
    
    func InvalidInput() {
      //  view?.SetLabeLMessage(message: "Enter person name")
        view?.ShowPopUp(_with: "Enter person name")
    }

}
