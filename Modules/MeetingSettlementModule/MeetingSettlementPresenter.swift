//
//  MeetingSettlementModulePresenter.swift
//  SharingSpendings
//
//  Created by User on 03.10.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class MeetingSettlementPresenter: MeetingSettlementPresenterProtocol{
    
    var router: BackableProtocol?
    var view: MeetingSettlementViewControllerProtocol?
    var presenter: MeetingSettlementPresenterProtocol?
    var meeting: Meeting?
    
    func viewWillAppear() {
        view?.setTableViewData(debts: (meeting?.calculateDebts(balances: (meeting?.calculateBalance())!))!)
    }
    
    func backButtonClicked() {
        router?.back()
    }
    
    
}
