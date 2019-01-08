//
//  NewItemModuleAbstraction.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol NewItemViewControllerProtocol {
    func setMessageLabel(message: String)
    func setPeopleData(people: [Person])
    func updateMessage(message: String)
    func fillWithItemData(item: Item)
    func getItemData()-> ItemData
    func switchButtons()
    func showPopUp(_with message: String)
    func setTitle(title: String)
}

protocol NewItemPresenterProtocol {
    func viewWillAppear()
    func addButtonClicked()
    func backButtonClicked()
    func confirmButtonClicked()
    func invalidInput(error: itemAdditionError)
}
