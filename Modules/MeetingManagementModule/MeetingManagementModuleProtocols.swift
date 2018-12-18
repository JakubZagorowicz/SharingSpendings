//
//  MeetingsManagmentModuleProtocols.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import CoreData

protocol MeetingManagementModuleViewControllerProtocol {
    func SetTableData(people: [(Person, Double)], items: [Item])
    func SetMessageLabel(message: String)
    func ShowPopUp(_with message: String)
    func SetMeetingName(name: String)
    func SetAddItemButton(isEnabled: Bool)
    func SetSettleUpButton(isEnabled: Bool)

}

protocol MeetingManagementModulePresenterProtcol {
    func ViewWillAppear()
    func ItemClicked(item: Item)
    func PersonClicked(person: Person)
    func AddPersonClicked()
    func AddItemClicked()
    func DeleteItemClicked(item:Item)
    func DeletePersonClicked(person:Person)
    func BackButtonClicked()
    func SettleUpButtonClicked()
}
