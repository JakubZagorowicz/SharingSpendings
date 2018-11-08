//
//  DataManager.swift
//  SharingSpendings
//
//  Created by User on 08.11.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

class DataManager {
    static let dataManager = DataManager()
    let dataController : DataController
    
    private init(){
        dataController = DataController(dataModelName: "DataModel")
    }
    
    
}
