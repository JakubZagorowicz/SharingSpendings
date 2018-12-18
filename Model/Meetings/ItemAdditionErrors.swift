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
    case NoPriceEntered
    case NegativePrice
    case NoPersonUsingItem
    case NoBuyerPicked
    
    func GetErrorMessage() -> String {
        var message: String
        switch self {
        case ItemAdditionError.NoPriceEntered:
            message = "Enter price"
        case ItemAdditionError.NegativePrice:
            message = "Price has to be positive number"
        case ItemAdditionError.NoNameEntered:
            message = "Enter item name"
        case ItemAdditionError.NoPersonUsingItem:
            message = "Atleast one participant have to be using this item"
        case ItemAdditionError.NoBuyerPicked:
            message = "Pick participant, who paid for item"
//        default:
//            message = ""
        }
        return message
    }
}
