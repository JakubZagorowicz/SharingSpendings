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
    func SetTableData(people: [Person], items: [Item])
    func SetBalance(for index: Int, balance: Double)
    func SetMessageLabel(message: String)
}

protocol MeetingManagmentModulePresenterProtcol {
    func ViewWillAppear()
    func ItemClicked(item: Item)
    func PersonClicked(person: Person)
    func AddPersonClicked()
    func AddItemClicked()
    func DeleteItemClicked(item:Item)
    func DeletePersonClicked(person:Person)
    func BackButtonClicked()
}