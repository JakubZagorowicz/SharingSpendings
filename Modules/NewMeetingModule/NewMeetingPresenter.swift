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
    
    func addButtonClicked() {
        let name = view?.getTextFieldData()
        do {
            try DataManager.dataManager.dataController.addEntity(entityData: MeetingData(name: name!))
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        router?.back()
    }
    
    func backButtonClicked() {
        router?.back()
    }
    
    func invalidNameProvided(){
        view?.showPopUp(_with: "Enter meeting name")
    }
}
