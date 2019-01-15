//
//  MeetingsModulePresenter.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import CoreData

class MeetingsPresenter : MeetingsPresenterProtocol{
    
    var view: MeetingsViewControllerProtocol?
    var router: MeetingModuleRoutingProtocol?
    var meetings = [Meeting]()
    
    func viewWillAppear() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Meeting")
        do{
            self.meetings = try Array((DataController.entityManager.managedObjectContext.fetch(fetchRequest))) as! [Meeting]
        }
        catch let error{
            print("Could not fetch. \(error)")
        }
        
        view?.setTableData(meetings: meetings)
    }
    
    func addMeetingClicked() {
        router?.newMeetingButtonClicked()
    }
    
    func meetingClicked(meeting: Meeting) {
        router?.meetingClicked(meeting: meeting)
    }
    
    func deleteMeetingClicked(meeting: Meeting) {
        do {
            try DataController.entityManager.deleteEntity(entity: meeting)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        viewWillAppear()
    }
    
    func sectionButtonClicked(sectionIndex: Int) {
        view?.scrollToSection(index: sectionIndex)
    }
    
    func cellLongPress(section: Int, row: Int) {
        view?.presentOptions()
    }
}
