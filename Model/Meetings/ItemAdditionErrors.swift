//
//  ItemAdditionErrors.swift
//  SharingSpendings
//
//  Created by User on 26.09.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

enum itemAdditionError {
    case noNameEntered
    case noPriceEntered
    case negativePrice
    case noPersonUsingItem
    case noBuyerPicked
    
    func GetErrorMessage() -> String {
        var message: String
        switch self {
        case itemAdditionError.noPriceEntered:
            message = "Enter price"
        case itemAdditionError.negativePrice:
            message = "Price has to be positive number"
        case itemAdditionError.noNameEntered:
            message = "Enter item name"
        case itemAdditionError.noPersonUsingItem:
            message = "Atleast one participant have to be using this item"
        case itemAdditionError.noBuyerPicked:
            message = "Pick participant, who paid for item"
        }
        return message
    }
}
