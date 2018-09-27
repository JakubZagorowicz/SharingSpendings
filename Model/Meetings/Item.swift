//
//  Item.swift
//  SharingSpendings
//
//  Created by User on 12.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

extension Item {
}

struct ItemData{
    var name: String
    var cost: Double
    var buyer: Person
    var usedBy: Dictionary<Person, Bool>
    
    init(name: String, cost: Double, buyer: Person, usedBy: Dictionary<Person, Bool>) {
        self.name = name
        self.cost = cost
        self.buyer = buyer
        self.usedBy = usedBy
    }
}
