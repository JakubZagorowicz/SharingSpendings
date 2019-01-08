//
//  MeetingSettlementProtocols.swift
//  SharingSpendings
//
//  Created by User on 03.10.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol MeetingSettlementViewControllerProtocol {
    func setTableViewData(debts: [Debt])
}

protocol MeetingSettlementPresenterProtocol {
    func viewWillAppear()
    func backButtonClicked()
}

