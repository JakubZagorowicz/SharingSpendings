//
//  MeetingSettlementModulePresenter.swift
//  SharingSpendings
//
//  Created by User on 03.10.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class MeetingSettlementModulePresenter: MeetingSettlementModulePresenterProtocol{
    
    var router: BackableProtocol?
    var view: MeetingSettlementModuleViewControllerProtocol?
    var presenter: MeetingSettlementModulePresenterProtocol?
    var meeting: Meeting?
    
    func ViewWillAppear() {
        view?.SetTableViewData(debts: (meeting?.CalculateDebts(balances: (meeting?.CalculateBalance())!))!)
    }
    
    func BackButtonClicked() {
        router?.Back()
    }
    
    
}
