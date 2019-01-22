//
//  DebtData.swift
//  SharingSpendings
//
//  Created by User on 18.12.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

struct DebtData: EntityDataProtocol{
    var entityName: String = "Debt"
    
    var attributes: [(String, Any)] = [(String, Any)]()
    
    var from: Person
    var to: Person
    var howMuch: Double
    
    init(from: Person, to: Person, howMuch: Double) {
        self.from = from
        self.to = to
        self.howMuch = howMuch
        assignAttributes()
    }
}
