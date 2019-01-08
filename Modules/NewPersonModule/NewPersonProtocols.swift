//
//  NewPersonModuleAbstraction.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol NewPersonPresenterProtocol {
    func addButtonClicked()
    func backButtonClicked()
    func viewWillAppear()
    func invalidInput()
    func confirmButtonClicked()
}

protocol NewPersonViewControllerProtocol {
    func showPersonDetails(person: Person)
    func getTextFieldData() -> String
    func setLabeLMessage(message: String)
    func switchButtons()
    func showPopUp(_with message: String)
    func setTitle(title: String)
}
