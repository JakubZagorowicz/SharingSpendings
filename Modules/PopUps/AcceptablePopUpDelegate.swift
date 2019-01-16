//
//  AcceptablePopUpViewController.swift
//  SharingSpendings
//
//  Created by User on 16.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol AcceptablePopUpDelegate {
    func acceptablePopUp(_ acceptablePopUp: AcceptablePopUp, didResolveWith result: Bool)
}
