//
//  Debt.swift
//  SharingSpendings
//
//  Created by User on 03.10.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class Debt{
    var from: Person
    var to: Person
    var howMuch: Double
    
    init(from: Person, to: Person, howMuch: Double) {
        self.from = from
        self.to = to
        self.howMuch = howMuch
    }
}
