//
//  NewMeetingModuleProtocols.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol NewMeetingModuleViewControllerProtocol {
    func GetTextFieldData() -> String
    func SetMessageLabel(message: String)
    func ShowPopUp(_with message: String)
}

protocol NewMeetingModulePresenterProtocol {
    func AddButtonClicked()
    func BackButtonClicked()
    func InvalidName()
}
