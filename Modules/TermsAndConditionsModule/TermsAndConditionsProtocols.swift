//
//  TermsAndConditionsProtocols.swift
//  SharingSpendings
//
//  Created by User on 22.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol TermsAndConditionsPresenterProtocol {
    func backButtonClicked()
    func viewWillAppear()
}

protocol TermsAndConditionsViewControllerProtocol {
    func toggleToUserTermsMode()
    func toggleToPrivacyPolicyMode()
}
