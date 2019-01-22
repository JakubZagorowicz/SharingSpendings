//
//  TermsAndConditionsPresenter.swift
//  SharingSpendings
//
//  Created by User on 22.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class TermsAndConditionsPresenter: TermsAndConditionsPresenterProtocol{
    var view: TermsAndConditionsViewControllerProtocol?
    var router: BackableProtocol?
    var mode: String?
    
    func backButtonClicked() {
        router?.back()
    }
    
    func viewWillAppear() {
        if mode == "User Terms"{
            view?.toggleToUserTermsMode()
        }
        else{
            view?.toggleToPrivacyPolicyMode()
        }
    }
    
}
