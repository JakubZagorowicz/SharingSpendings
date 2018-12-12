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
    let gradientLayer = CAGradientLayer()
    let gradientLayerView = UIView(frame: .zero)
    
    func SetUpGradient(color: UIColor){

        gradientLayer.colors = [color.withAlphaComponent(0.7).cgColor, color.withAlphaComponent(0).cgColor]
        gradientLayer.transform = CATransform3DMakeRotation(CGFloat.pi/2, 0, 0, 1)

        gradientLayerView.frame = CGRect(x: self.frame.maxX-balanceLabel.frame.width, y: 0, width: balanceLabel.frame.width, height: self.frame.height)
        
        gradientLayer.frame = CGRect(x: 5, y: 0, width: balanceLabel.frame.width-5, height: self.frame.height)
        gradientLayerView.layer.addSublayer(gradientLayer)
        
        self.addSubview(gradientLayerView)
        self.sendSubviewToBack(gradientLayerView)

        self.bringSubviewToFront(balanceLabel!)
    }
    func SetBalance(balance: Double){
        var color = UIColor.clear
        if balance < 0{
            color = UIColor(rgb: 0xff0000)
        }
        else{
            color = UIColor(rgb: 0x37a766)
        }
        SetUpGradient(color: color)
        balanceLabel.text = String(format: EsteticsModel.numberFormat, balance)
        balanceLabel.textColor = EsteticsModel.inCellTextColor.withAlphaComponent(1)
      //  balanceLabel.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)

    }
}
