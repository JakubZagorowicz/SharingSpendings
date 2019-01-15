//
//  usedByCell.swift
//  SharingSpendings
//
//  Created by User on 27.09.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class CheckboxCell: UITableViewCell{        
    var checkBox = CheckBox()
    
    func setupCell(){        
        addSubview(checkBox)
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        checkBox.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        checkBox.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        checkBox.widthAnchor.constraint(equalTo: checkBox.heightAnchor).isActive = true
    }
}
