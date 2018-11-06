//
//  Person.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

extension Person{
    
}

struct PersonData: EntityDataProtocol {
    let entityName: String = "Person"

    var attributes: [(String, Any)] = [(String, Any)]()
   
    
    var name: String
    var meeting: Meeting
    
    init(name: String, meeting: Meeting) {
        self.name = name
        self.meeting = meeting
//        attributes.append(("name", name))
//        attributes.append(("meeting", meeting))
        AssignAttributes()
    }
}
