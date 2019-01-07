//
//  MeetingsModulePresenter.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import CoreData

class MeetingsModulePresenter : MeetingsModulePresenterProtocol{
    
    var meetings = [Meeting]()
    
    func ViewWillAppear() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Meeting")
        do{
            self.meetings = try Array((DataManager.dataManager.dataController.managedObjectContext.fetch(fetchRequest))) as! [Meeting]
        }
        catch let error{
            print("Could not fetch. \(error)")
        }


        view?.SetTableData(meetings: meetings)
    }
    
    func AddMeetingClicked() {
        router?.NewMeetingButtonClicked()
    }
    
    func MeetingClicked(index: Int) {
        let meeting = meetings[index]
        router?.MeetingClicked(meeting: meeting)
    }
    
    func DeleteMeetingClicked(index: Int) {
        let meeting  = meetings[index]

        do {
            try DataManager.dataManager.dataController.DeleteEntity(entity: meeting)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        ViewWillAppear()
    }
    
    func SectionButtonClicked(sectionIndex: Int) {
        view?.ScrollToSection(index: sectionIndex)
    }
    
    var view: MeetingsModuleViewControllerProtocol?
    var router: MeetingModuleRoutingProtocol?
    
}
