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

struct ItemData: EntityDataProtocol{
    var attributes: [(String, Any)] = [(String, Any)]()
    
    let entityName: String = "Item"

    var name: String
    var cost: Double
    var buyer: Person
    var usedBy: [Person]
    
    init(name: String, cost: Double, buyer: Person, usedBy: [Person]) {
        self.name = name
//        attributes.append(("name", name))
        self.cost = cost
//        attributes.append(("cost", cost))
        self.buyer = buyer
//        attributes.append(("buyer", buyer))
        self.usedBy = usedBy
//        attributes.append(("usedBy", usedBy))
        AssignAttributes()
    }
}
