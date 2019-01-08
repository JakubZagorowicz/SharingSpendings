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

}

protocol MeetingsPresenterProtocol {
    func viewWillAppear()
    func addMeetingClicked()
    func meetingClicked(index: Int)
    func deleteMeetingClicked(index: Int)
    func sectionButtonClicked(sectionIndex: Int)
    func cellLongPress(section: Int, row: Int)
}
