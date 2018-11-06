//
//  Meeting.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

struct MeetingData: EntityDataProtocol {
    var attributes: [(String, Any)] = [(String, Any)]()

    var entityName: String = "Meeting"
    var name: String
    var peopleAttending: [Person]
    
    init(name: String) {
        self.name = name
        peopleAttending = [Person]()
        AssignAttributes()
    }
}

