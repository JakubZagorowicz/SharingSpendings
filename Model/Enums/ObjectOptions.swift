//
//  PersonHoldOptions.swift
//  SharingSpendings
//
//  Created by User on 15.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import Foundation

enum ObjectOptions {
    case meeting
    case person
    case item
    case debt
    
    func getOptions() -> [SelectableOptions] {
        var options = [SelectableOptions]()
        switch self {
        case .meeting:
            options = [SelectableOptions.delete]
        case .person:
            options = [.edit, .delete]
        case .item:
            options = [.edit, .delete]
        case .debt:
            options = []
        }
        return options
    }
}
