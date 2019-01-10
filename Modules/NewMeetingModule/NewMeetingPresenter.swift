//
//  NewMeetingModulePresentere.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class NewMeetingPresenter : NewMeetingPresenterProtocol{
    
    var view : NewMeetingViewControllerProtocol?
    var router: BackableProtocol?
    
    func addButtonClicked(nameData: String) {
        do {
            try DataController.entityManager.addEntity(entityData: MeetingData(name: nameData))
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        router?.back()
    }
    
    func backButtonClicked() {
        router?.back()
    }
    
    func invalidNameProvided(){
        view?.showMessagePopUp(message: "Enter meeting name")
    }
}
