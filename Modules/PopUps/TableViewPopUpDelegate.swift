//
//  TableViewPopUpDelegate.swift
//  SharingSpendings
//
//  Created by User on 15.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol TableViewPopUpDelegate{
    func tableViewPopUp(_ tableViewPopUp: TableViewPopUp, cellSelectedAtIndex index: Int) -> Void
}
