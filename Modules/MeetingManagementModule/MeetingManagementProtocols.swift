//
//  MeetingsManagmentModuleProtocols.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol MeetingManagementViewControllerProtocol {
    func setTableData(people: [(Person, Double)], items: [Item])
    func setDebtsData(debts: [Debt])
    func showPopUp(_with message: String)
    func setMeetingName(name: String)
    func setAddItemButton(isEnabled: Bool)
    func addButtonIsVisible(isVisible: Bool)
    func scrollToSection(index: Int)
}

protocol MeetingManagementPresenterProtcol {
    func viewWillAppear()
    func itemClicked(item: Item)
    func personClicked(person: Person)
    func deleteItemClicked(item:Item)
    func deletePersonClicked(person:Person)
    func backButtonClicked()
    func addButtonClicked()
    func peopleButtonClicked()
    func itemsButtonClicked()
    func settlementButtonClicked()
    func setPresentedSection(toIndex: Int)
    func closeEventButtonClicked()
}
