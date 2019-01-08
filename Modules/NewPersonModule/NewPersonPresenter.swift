//
//  NewPersonPresenter.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class NewPersonPresenter : NewPersonPresenterProtocol {
    
    var view: NewPersonViewControllerProtocol?
    var router: BackableProtocol?
    var meeting: Meeting?
    var person: Person?
    
    func viewWillAppear() {
        if person != nil{
            view?.showPersonDetails(person: person!)
            view?.switchButtons()
            view?.setTitle(title: "Edit person")
        }
    }
    
    func addButtonClicked() {
        let name = view?.getTextFieldData()
        do{
            let personData = PersonData(name: name!, meeting: meeting!)
            try DataManager.dataManager.dataController.addEntity(entityData: personData)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        router?.back()
    }
    
    func backButtonClicked() {
        router?.back()
    }
    
    func confirmButtonClicked() {
        let name = view?.getTextFieldData()
        do{
            try DataManager.dataManager.dataController.updateEntity(entityData: PersonData(name: name!, meeting: meeting!), entity: person!)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        router?.back()
    }
    
    func invalidInput() {
        view?.showPopUp(_with: "Enter person name")
    }

}
