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
  //  var navigator: UINavigationController?
    var navigator: CustomNavigatorController?
    
    func InitializeMothership(){
        let rootVC = Builder.BuildMeetingsModule(router: self)
  //      navigator = UINavigationController(rootViewController: rootVC)
     //   let rootVC = Builder.BuildModule(router: self)
        navigator = CustomNavigatorController(rootViewController: rootVC)
        navigator?.navigationBar.isHidden = true
    }
    
    func GoToNewMeetingModule(){
        navigator?.pushViewController(Builder.BuildNewMeetingModule(router: self), animated: true)
    }
    
    func GoToMeetingManagmentModule(meeting: Meeting){
       navigator?.pushViewController(Builder.BuildMeetingManagmentModule(router: self, meeting: meeting), animated: true)
      //  navigator?.setViewControllers([Builder.BuildMeetingManagmentModule(router: self, meeting: meeting)], animated: true)
    }
    
    func GoToMeetingsModule(){
        navigator?.popToRootViewController(animated: true)
    }
    
    func GoToNewItemModule(meeting: Meeting){
        navigator?.pushViewController(Builder.BuildNewItemModule(router: self,meeting: meeting), animated: true)
    }
    
    func GoToNewItemModule(item: Item, meeting: Meeting){
        navigator?.pushViewController(Builder.BuildNewItemModule(router: self,item: item, meeting: meeting), animated: true)
    }
    
    func GoToNewPersonModule(meeting: Meeting){
        navigator?.pushViewController(Builder.BuildNewPersonModule(router: self, meeting: meeting), animated: true)
    }
    
    func GoToNewPersonModule(person: Person, meeting: Meeting){
        navigator?.pushViewController(Builder.BuildNewPersonModule(router: self, person: person, meeting: meeting), animated: true)
    }
    
    func GoToMeetingSettlementModule(meeting: Meeting){
        navigator?.pushViewController(Builder.BuildMeetingSettlementModule(router: self, meeting: meeting), animated: true)
    }
    func GoBack(){
        navigator?.popViewController(animated: true)
    }
}

extension Mothership : BackableProtocol{
    func Back(){
        GoBack()
    }
}
extension Mothership : MeetingManagementRoutingProtocol{

    
    func ItemClicked(item: Item, meeting: Meeting) {
        GoToNewItemModule(item: item, meeting: meeting)
    }
    
    func NewItemButtonClicked(meeting: Meeting) {
        GoToNewItemModule(meeting: meeting)
    }
    
    func PersonClicked(person: Person, meeting: Meeting) {
        GoToNewPersonModule(person: person, meeting: meeting)
    }
    
    func NewPersonClicked(meeting: Meeting) {
        GoToNewPersonModule(meeting: meeting)
    }
    
    func SettleUpButtonClicked(meeting: Meeting) {
        GoToMeetingSettlementModule(meeting: meeting)
    }
}

extension Mothership : MeetingModuleRoutingProtocol{
    func MeetingClicked(meeting: Meeting) {
        GoToMeetingManagmentModule(meeting: meeting)
    }
    func NewMeetingButtonClicked(){
        GoToNewMeetingModule()
    }
}
