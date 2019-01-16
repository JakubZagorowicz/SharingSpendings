//
//  Person.swift
//  SharingSpendings
//
//  Created by User on 16.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import Foundation

extension Person{
    static func getOptions() -> [SelectableOptions]{
        return [SelectableOptions.edit,SelectableOptions.delete]
    }
}
