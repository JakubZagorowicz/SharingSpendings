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
    
    var fromLabel = UILabel()
    var toLabel = UILabel()
    var howMuchLabel = UILabel()
    
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
        
        SetLabelsConstraints()
    }
    private func SetLabelsConstraints(){
        
        addSubview(fromLabel)
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        fromLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        fromLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        fromLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fromLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        
        addSubview(howMuchLabel)
        howMuchLabel.translatesAutoresizingMaskIntoConstraints = false
        howMuchLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        howMuchLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        howMuchLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        howMuchLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        addSubview(toLabel)
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        toLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        toLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        toLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        toLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
}
