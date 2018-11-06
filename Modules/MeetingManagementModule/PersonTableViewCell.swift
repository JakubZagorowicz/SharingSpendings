//
//  PersonTableViewCell.swift
//  SharingSpendings
//
//  Created by User on 26.09.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class PersonTableViewCell: UITableViewCell{
    @IBOutlet weak var balanceLabel: UILabel!
    func SetBalance(balance: Double){
        balanceLabel.text = String(format: "%.02f", balance)
        if balance < 0{
            balanceLabel.textColor = UIColor.red
        }
        else{
            balanceLabel.textColor = UIColor.green
        }
    }
}
