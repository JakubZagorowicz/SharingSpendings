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
    let balanceLabel = UILabel(frame: .zero)
    let gradientLayer = CAGradientLayer()
    let gradientLayerView = UIView(frame: .zero)
    
    func SetUpGradient(color: UIColor){

        gradientLayer.colors = [color.withAlphaComponent(0.7).cgColor, color.withAlphaComponent(0).cgColor]
        gradientLayer.transform = CATransform3DMakeRotation(CGFloat.pi/2, 0, 0, 1)
        self.addSubview(gradientLayerView)
        self.sendSubviewToBack(gradientLayerView)

//        gradientLayerView.frame = CGRect(x: self.frame.maxX-balanceLabel.frame.width, y: 0, width: balanceLabel.frame.width, height: self.frame.height)
        gradientLayerView.translatesAutoresizingMaskIntoConstraints = false
        gradientLayerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        gradientLayerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        gradientLayerView.heightAnchor.constraint(equalToConstant: TableViewModel.cellHeight).isActive = true
        gradientLayerView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        gradientLayer.frame = CGRect(x: 5, y: 0, width: 100, height: TableViewModel.cellHeight)
        
        
        gradientLayerView.layer.addSublayer(gradientLayer)
        

//        self.bringSubviewToFront(balanceLabel)
    }
    
    func SetBalance(balance: Double){
        var color = UIColor.clear
        if balance < 0{
            color = UIColor(rgb: 0xff0000)
        }
        else{
            color = UIColor(rgb: 0x37a766)
        }
        balanceLabel.textAlignment = .right
        balanceLabel.text = String(format: EsteticsModel.numberFormat, balance)
        balanceLabel.textColor = EsteticsModel.inCellTextColor
        balanceLabel.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize-1)

        SetUpGradient(color: color)

    }
    func SetUpCell(name: String){
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(balanceLabel)
//        balanceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        balanceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        balanceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        balanceLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        balanceLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        textLabel?.text = name
        textLabel?.textColor = EsteticsModel.inCellTextColor
        textLabel?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
        

    }
}
