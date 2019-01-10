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
    
    func addButtonClicked(nameData: String) {
        do{
            let personData = PersonData(name: nameData, meeting: meeting!)
            try DataController.entityManager.addEntity(entityData: personData)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        router?.back()
    }
    
    func backButtonClicked() {
        router?.back()
    }
    
    func confirmButtonClicked(nameData: String) {
        do{
            try DataController.entityManager.updateEntity(entityData: PersonData(name: nameData, meeting: meeting!), entity: person!)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        router?.back()
    }
    
    func invalidInput() {
        view?.showAdditionErrorPopUp(with: "Enter person name")
    }

}
