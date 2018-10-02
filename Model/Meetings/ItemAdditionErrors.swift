//
//  ItemAdditionErrors.swift
//  SharingSpendings
//
//  Created by User on 26.09.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

enum ItemAdditionError {
    case NoNameEntered
    case InvalidPriceFormat
    case NegativePrice
    case NoPersonUsingItem
    
    func GetErrorMessage() -> String {
        var message: String
        switch self {
        case ItemAdditionError.InvalidPriceFormat:
            message = "Invalid price format"
        case ItemAdditionError.NegativePrice:
            message = "Price has to be positive number"
        case ItemAdditionError.NoNameEntered:
            message = "Enter item name"
        case ItemAdditionError.NoPersonUsingItem:
            message = "Atleast one person have to be using this item"
//        default:
//            message = ""
        }
        return message
    }
}
