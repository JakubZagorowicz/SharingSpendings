//
//  ViewsEsteticsModel.swift
//  SharingSpendings
//
//  Created by User on 14.11.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class EsteticsModel {
    static var inCellTextColor = UIColor.white
    static var messageLabelTextColor = UIColor.black
    static var pickerViewTextColor = UIColor.white
    static var textFieldTextColor = UIColor.white
    static var titleLabelTextColor = UIColor.white
    static var titleLabelFont = UIFont.systemFont(ofSize: floor(15+UIScreen.main.bounds.height*0.015))
    
    static var textFieldTransparency = 1
    
    static var numberFormat = "%.02f"
    
    static var positiveBalanceColor = UIColor.green
    static var negativeBalanceColor = UIColor(rgb: 0xff5656)
    
    static var deleteButtonBackgroungColor = UIColor(rgb: 0xa73737)
    static var editButtonBackgroundColor = UIColor(rgb: 0x377ca7)
    static var placeholderTextColor = UIColor(rgb: 0x4e6469)
}

class TableViewModel {
    static var cellHeight = 30 + UIScreen.main.bounds.height*0.025
    static var inCellFontSize = floor(10 + UIScreen.main.bounds.height*0.015)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
