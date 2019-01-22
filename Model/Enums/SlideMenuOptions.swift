//
//  SlideMenuOptions.swift
//  SharingSpendings
//
//  Created by User on 22.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

enum SlideMenuOptions {
    case privacyPolicy
    case userTerms
    
    func getName() -> String{
        var name: String = ""
        switch self {
        case .privacyPolicy:
            name = "Privacy Policy"
        case .userTerms:
            name = "User Terms"
        }
        return name
    }
}
