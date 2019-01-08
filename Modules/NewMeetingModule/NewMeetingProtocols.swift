//
//  NewMeetingModuleProtocols.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol NewMeetingViewControllerProtocol {
    func getTextFieldData() -> String
    func showMessagePopUp(message: String)
}

protocol NewMeetingPresenterProtocol {
    func addButtonClicked()
    func backButtonClicked()
    func invalidNameProvided()
}
