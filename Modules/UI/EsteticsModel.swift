//
//  ViewsEsteticsModel.swift
//  SharingSpendings
//
//  Created by User on 14.11.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

struct EsteticsModel {
    static var inCellTextColor = UIColor.white
    static var messageLabelTextColor = UIColor.black
    static var pickerViewTextColor = UIColor.white
    static var textFieldTextColor = UIColor.white
    static var titleLabelTextColor = UIColor.white
    static var titleLabelFont = UIFont.systemFont(ofSize: floor(13+UIScreen.main.bounds.height*0.015))
    static var textViewFont = UIFont.systemFont(ofSize: floor(10 + UIScreen.main.bounds.height*0.015))
    
    static var textFieldTransparency = 1
    
    static var numberFormat = "%.02f"
    
    static var positiveBalanceColor = UIColor.green
    static var negativeBalanceColor = UIColor(rgb: 0xff5656)
    
    static var deleteButtonBackgroungColor = UIColor(rgb: 0xa73737)
    static var editButtonBackgroundColor = UIColor(rgb: 0x377ca7)
    static var placeholderTextColor = UIColor(rgb: 0x4e6469)
    
    static var cellHeight = 30 + UIScreen.main.bounds.height*0.025
    static var inCellFontSize = floor(10 + UIScreen.main.bounds.height*0.015)
    static var headerLabelFontSize = inCellFontSize
    static var headerLabelTextColor = UIColor.white
    
    static func setLabel(style: UILabelStyle, label: UILabel){
        switch style {
        case .header:
            label.font = UIFont.systemFont(ofSize: EsteticsModel.headerLabelFontSize)
            label.textColor = EsteticsModel.headerLabelTextColor
        case .title:
            label.font = EsteticsModel.titleLabelFont
            label.textColor = EsteticsModel.titleLabelTextColor
        case .tableCell:
            label.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
            label.textColor = EsteticsModel.inCellTextColor
        case .inactiveTableCell:
            label.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
            label.textColor = EsteticsModel.placeholderTextColor
        case .whiteBackgroundCell:
            label.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
            label.textColor = .black
        }
    }
}

enum UILabelStyle {
    case title
    case header
    case tableCell
    case inactiveTableCell
    case whiteBackgroundCell
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
