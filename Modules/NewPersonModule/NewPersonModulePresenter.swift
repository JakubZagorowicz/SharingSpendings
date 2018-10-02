//
//  NewPersonPresenter.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class NewPersonModulePresenter : NewPersonModulePresenterProtocol {
    
    func ConfirmButtonClicked() {
        let name = view?.GetTextFieldData()
//        person?.setValue(name, forKey: "name")
//        do {
//            try dataController?.managedObjectContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
        do{
            try dataController?.UpdateEntity(entityData: PersonData(name: name!, meeting: meeting!), entity: person!)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        router?.GoBack()
    }
    
    func InvalidInput() {
        view?.SetLabeLMessage(message: "Enter person name")
    }
    
    
    func ViewWillAppear() {
        if person != nil{
            view?.ShowPersonDetails(person: person!)
            view?.SwitchButtons()
        }
    }
    
    func AddButtonClicked() {
        let name = view?.GetTextFieldData()

        do{
            let personData = PersonData(name: name!, meeting: meeting!)
            try dataController?.AddEntity(entityData: personData)
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
//        let managedContext = dataController?.managedObjectContext
//        let record = NSManagedObject(entity: NSEntityDescription.entity(forEntityName: "Person", in: managedContext!)!, insertInto: managedContext)
//        record.setValue(name, forKey: "name")
//        record.setValue(meeting, forKey: "meeting")
//
//        do {
//            try dataController?.managedObjectContext.save()
//
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
        
        router?.GoBack()
    }
    
    func BackButtonClicked() {
        router?.GoBack()
    }
    
    var view: NewPersonModuleViewControllerProtocol?
    var router: Mothership?
    var dataController: DataControllerProtocol?
    var meeting: Meeting?
    
    var person: Person?
}
