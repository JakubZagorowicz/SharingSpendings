//
//  Mothership.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class Mothership {
    var navigator: UINavigationController?
    
    func InitializeMothership(dataController: DataController){
        let rootVC = Builder.BuildMeetingsModule(router: self, dataController: dataController)
        navigator = UINavigationController(rootViewController: rootVC)
        navigator?.navigationBar.isHidden = true
    }
    
    func GoToMainModule(){
       // navigator?.popToRootViewController(animated: true)
    }
    
    func GoToNewMeetingModule(dataController: DataController){
        navigator?.pushViewController(Builder.BuildNewMeetingModule(router: self, dataController: dataController), animated: true)
    }
    
    func GoToMeetingManagmentModule(dataController: DataController, meeting: Meeting){
        navigator?.pushViewController(Builder.BuildMeetingManagmentModule(router: self, meeting: meeting, dataController: dataController), animated: true)
    }
    
    func GoToMeetingsModule(){
        navigator?.popToRootViewController(animated: true)
        
    }
    
    func GoToLoginModule(animated: Bool){
        navigator?.pushViewController(Builder.BuildLoginModule(router: self), animated: animated)
    }
    
    func GoToNewItemModule(dataController: DataController, people: [Person], meeting: Meeting){
        navigator?.pushViewController(Builder.BuildNewItemModule(router: self, dataController: dataController, people: people, meeting: meeting), animated: true)
    }
    
    func GoToNewItemModule(dataController: DataController, people: [Person], item: Item, meeting: Meeting){
        navigator?.pushViewController(Builder.BuildNewItemModule(router: self, dataController: dataController, people: people, item: item, meeting: meeting), animated: true)
    }
    
    func GoToNewPersonModule(dataController: DataController, meeting: Meeting){
        navigator?.pushViewController(Builder.BuildNewPersonModule(router: self, dataController: dataController, meeting: meeting), animated: true)
    }
    
    func GoToNewPersonModule(dataController: DataController, person: Person, meeting: Meeting){
        navigator?.pushViewController(Builder.BuildNewPersonModule(router: self, dataController: dataController, person: person, meeting: meeting), animated: true)
    }
    
    func GoBack(){
        navigator?.popViewController(animated: true)
    }
}
