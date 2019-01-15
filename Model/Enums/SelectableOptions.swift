//
//  SelectableOptions.swift
//  SharingSpendings
//
//  Created by User on 15.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import Foundation

enum SelectableOptions {
    case edit
    case delete
    
    func getName() -> String{
        switch self {
        case .edit:
            return "edit"
        case .delete:
            return "delete"
        }
    }
}
