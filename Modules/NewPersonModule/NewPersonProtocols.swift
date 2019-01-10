//
//  NewPersonModuleAbstraction.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol NewPersonPresenterProtocol {
    func addButtonClicked(nameData: String)
    func backButtonClicked()
    func viewWillAppear()
    func invalidInput()
    func confirmButtonClicked(nameData: String)
}

protocol NewPersonViewControllerProtocol {
    func showPersonDetails(person: Person)
    func setLabeLMessage(message: String)
    func switchButtons()
    func showAdditionErrorPopUp(with message: String)
    func setTitle(title: String)
}
