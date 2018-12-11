//
//  Checkbox.swift
//  SharingSpendings
//
//  Created by User on 30.11.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class Checkbox : UIButton {
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(#imageLiteral(resourceName: "checkbox_on"), for: .normal)
            }
            else {
                self.setImage(#imageLiteral(resourceName: "checkbox_off"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(Checkbox.buttonClicked), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton){
        if sender == self{
            isChecked = !isChecked
        }
    }
}
