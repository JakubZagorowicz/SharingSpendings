//
//  Item.swift
//  SharingSpendings
//
//  Created by User on 16.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import Foundation

extension Item {
    static func getOptions() -> [SelectableOptions]{
        return [SelectableOptions.edit,SelectableOptions.delete]
    }
}
