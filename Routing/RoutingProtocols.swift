//
//  BackableProtocol.swift
//  SharingSpendings
//
//  Created by User on 08.11.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol BackableProtocol {
    func back()
}

protocol MeetingManagementRoutingProtocol {
    func itemClicked(item: Item, meeting: Meeting)
    func newItemButtonClicked(meeting: Meeting)
    func personClicked(person: Person, meeting: Meeting)
    func newPersonClicked(meeting: Meeting)
}

protocol MeetingModuleRoutingProtocol {
    func meetingClicked(meeting: Meeting)
    func newMeetingButtonClicked()
}
