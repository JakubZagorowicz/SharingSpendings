//
//  MeetingsModuleProtocols.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol MeetingsModuleViewControllerProtocol {
    func SetTableData(meetings: [Meeting])
    func ScrollToSection(index: Int)

}

protocol MeetingsModulePresenterProtocol {
    func ViewWillAppear()
    func AddMeetingClicked()
    func MeetingClicked(index: Int)
    func DeleteMeetingClicked(index: Int)
    func SectionButtonClicked(sectionIndex: Int)
}
