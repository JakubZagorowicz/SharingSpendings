//
//  MeetingSettlementModulePresenter.swift
//  SharingSpendings
//
//  Created by User on 03.10.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class MeetingSettlementModulePresenter: MeetingSettlementModulePresenterProtocol{
    
    var router: Mothership?
    var view: MeetingSettlementModuleViewControllerProtocol?
    var presenter: MeetingSettlementModulePresenterProtocol?
    var dataController: DataController?
    var meeting: Meeting?
    
    func ViewWillApear() {
        view?.SetTableViewData(debts: (meeting?.CalculateDebts(balances: (meeting?.CalculateBalance())!))!)
    }
    
    func BackButtonClicked() {
        router?.GoBack()
    }
    
    
}
