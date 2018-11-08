//
//  BackableProtocol.swift
//  SharingSpendings
//
//  Created by User on 08.11.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol BackableProtocol {
    func Back()
}

protocol MeetingManagementRoutingProtocol {
    func ItemClicked(item: Item, meeting: Meeting)
    func NewItemButtonClicked(meeting: Meeting)
    func PersonClicked(person: Person, meeting: Meeting)
    func NewPersonClicked(meeting: Meeting)
    func SettleUpButtonClicked(meeting: Meeting)
}
