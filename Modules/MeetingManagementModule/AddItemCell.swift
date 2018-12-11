//
//  AddItemCell.swift
//  SharingSpendings
//
//  Created by User on 14.11.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class AddItemCell: UITableViewCell{
    @IBOutlet weak var AddItemButton: UIButton!
    
    func SetAddButton(isEnabled: Bool){
        AddItemButton.isEnabled = isEnabled
    }
}
