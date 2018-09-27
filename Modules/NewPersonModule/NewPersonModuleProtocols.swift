//
//  NewPersonModuleAbstraction.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol NewPersonModulePresenterProtocol {
    func AddButtonClicked()
    func BackButtonClicked()
    func ViewWillAppear()
    func InvalidInput()
    func ConfirmButtonClicked()
}

protocol NewPersonModuleViewControllerProtocol {
    func ShowPersonDetails(person: Person)
    func GetTextFieldData() -> String
    func SetLabeLMessage(message: String)
    func SwitchButtons()
}
