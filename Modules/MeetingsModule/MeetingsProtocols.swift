//
//  MeetingsModuleProtocols.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol MeetingsViewControllerProtocol {
    func setTableData(meetings: [Meeting])
    func scrollToSection(index: Int)
    func presentOptions()
    func addButtonIs(hidden: Bool)
}

protocol MeetingsPresenterProtocol {
    func presentedSectionChanged(to section: Int)
    func viewWillAppear()
    func addMeetingClicked()
    func meetingClicked(meeting: Meeting)
    func deleteMeetingClicked(meeting: Meeting)
    func sectionButtonClicked(sectionIndex: Int)
    func cellLongPress(section: Int, row: Int)
    func menuOptionClicked(option: SlideMenuOptions)
}
