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
    @IBOutlet weak var howMuchLabel: UILabel!
    
    func SetDebt(debt: Debt){
        fromLabel.text = debt.from.name
        fromLabel.textColor = EsteticsModel.inCellTextColor
        fromLabel.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
        
        toLabel.text = debt.to.name
        toLabel.textColor = EsteticsModel.inCellTextColor
        toLabel.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)

        
        howMuchLabel.text = String(format: EsteticsModel.numberFormat, debt.howMuch)
        howMuchLabel.textColor = EsteticsModel.inCellTextColor
        howMuchLabel.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)

    }
}
