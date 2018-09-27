//
//  NewMeetingModulePresentere.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import CoreData

class NewMeetingModulePresenter : NewMeetingModulePresenterProtocol{
    func AddButtonClicked() {
        let name = view?.GetTextFieldData()
        
        let entity = NSEntityDescription.entity(forEntityName: "Meeting", in: (dataController?.managedObjectContext)!)
        let meeting = NSManagedObject(entity: entity!, insertInto: (dataController?.managedObjectContext)!)
        
        meeting.setValue(name, forKey: "name")
        
        do {
            try dataController?.managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        router?.GoToMeetingsModule()
    }
    
    func BackButtonClicked() {
        router?.GoBack()
    }
    
    func InvalidName(){
        view?.SetMessageLabel(message: "Enter meeting name")
    }
    var view : NewMeetingModuleViewControllerProtocol?
    var router: Mothership?
    
    var dataController: DataController?
}
