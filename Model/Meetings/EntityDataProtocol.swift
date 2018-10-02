//
//  EntityDataProtocol.swift
//  SharingSpendings
//
//  Created by User on 01.10.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol EntityDataProtocol {
    var entityName: String { get }
    var attributes: [(String, Any)] { get set }
}
extension EntityDataProtocol{
    mutating func AssignAttributes(){
        let mirror = Mirror(reflecting: self)
        for case let (label?, value) in mirror.children{
            if label != "entityName" && label != "attributes"{
                attributes.append((label,value))
            }
        }
    }
}
