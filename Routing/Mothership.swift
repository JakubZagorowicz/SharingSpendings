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
    
    func initializeMothership(){
        let rootVC = Builder.buildMeetingsModule(router: self)
  //      navigator = UINavigationController(rootViewController: rootVC)
     //   let rootVC = Builder.BuildModule(router: self)
        navigator = CustomNavigatorController(rootViewController: rootVC)
        navigator?.navigationBar.isHidden = true
    }
    
    func goToNewMeetingModule(){
        navigator?.pushViewController(Builder.buildNewMeetingModule(router: self), animated: true)
    }
    
    func goToMeetingManagmentModule(meeting: Meeting){
       navigator?.pushViewController(Builder.buildMeetingManagmentModule(router: self, meeting: meeting), animated: true)
      //  navigator?.setViewControllers([Builder.BuildMeetingManagmentModule(router: self, meeting: meeting)], animated: true)
    }
    
    func goToMeetingsModule(){
        navigator?.popToRootViewController(animated: true)
    }
    
    func goToNewItemModule(meeting: Meeting){
        navigator?.pushViewController(Builder.buildNewItemModule(router: self,meeting: meeting), animated: true)
    }
    
    func goToNewItemModule(item: Item, meeting: Meeting){
        navigator?.pushViewController(Builder.buildNewItemModule(router: self,item: item, meeting: meeting), animated: true)
    }
    
    func goToNewPersonModule(meeting: Meeting){
        navigator?.pushViewController(Builder.buildNewPersonModule(router: self, meeting: meeting), animated: true)
    }
    
    func goToNewPersonModule(person: Person, meeting: Meeting){
        navigator?.pushViewController(Builder.buildNewPersonModule(router: self, person: person, meeting: meeting), animated: true)
    }
    
    func goToMeetingSettlementModule(meeting: Meeting){
        navigator?.pushViewController(Builder.buildMeetingSettlementModule(router: self, meeting: meeting), animated: true)
    }
    func goBack(){
        navigator?.popViewController(animated: true)
    }
}

extension Mothership : BackableProtocol{    
    func back(){
        goBack()
    }
}
extension Mothership : MeetingManagementRoutingProtocol{

    
    func itemClicked(item: Item, meeting: Meeting) {
        goToNewItemModule(item: item, meeting: meeting)
    }
    
    func newItemButtonClicked(meeting: Meeting) {
        goToNewItemModule(meeting: meeting)
    }
    
    func personClicked(person: Person, meeting: Meeting) {
        goToNewPersonModule(person: person, meeting: meeting)
    }
    
    func newPersonClicked(meeting: Meeting) {
        goToNewPersonModule(meeting: meeting)
    }
    
    func settleUpButtonClicked(meeting: Meeting) {
        goToMeetingSettlementModule(meeting: meeting)
    }
}

extension Mothership : MeetingModuleRoutingProtocol{
    func meetingClicked(meeting: Meeting) {
        goToMeetingManagmentModule(meeting: meeting)
    }
    func newMeetingButtonClicked(){
        goToNewMeetingModule()
    }
}
