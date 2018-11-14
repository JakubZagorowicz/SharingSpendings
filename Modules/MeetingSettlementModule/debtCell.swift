//
//  debtCell.swift
//  SharingSpendings
//
//  Created by User on 30.10.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class debtCell: UITableViewCell{
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var howMuchTable: UILabel!
    
    func SetDebt(debt: Debt){
        fromLabel.text = debt.from.name
        fromLabel.textColor = EsteticsModel.inCellTextColor
        
        toLabel.text = debt.to.name
        toLabel.textColor = EsteticsModel.inCellTextColor
        
        howMuchTable.text = String(format: EsteticsModel.numberFormat, debt.howMuch)
        howMuchTable.textColor = EsteticsModel.inCellTextColor
    }
}
