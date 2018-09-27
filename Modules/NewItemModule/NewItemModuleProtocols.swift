//
//  NewItemModuleAbstraction.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol NewItemModuleViewControllerProtocol {
    func SetMessageLabel(message: String)
    func SetPeopleData(people: [Person])
    func UpdateMessage(message: String)
    func FillWithItemData(item: Item)
    func GetItemData()-> ItemData
    func SwitchButtons()
}

protocol NewItemModulePresenterProtocol {
    func ViewWillAppear()
    func AddButtonClicked()
    func BackButtonClicked()
    func ConfirmButtonClicked()
    func InvalidInput(error: ItemAdditionError)
}
