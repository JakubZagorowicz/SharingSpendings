//
//  LoginModulePresenter.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class LoginModulePresenter : LoginModulePresenterProtocol{
    
    func OfflineModeButtonClick() {
 //       router?.GoToMeetingsModule()
    }
    
    var view: LoginModuleViewControllerProtocol?
    var router: Mothership?
}
