//
//  Meeting.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

protocol MeetingProtocol{
    func AddPerson(person: Person)
    func AddItem(item: Item)
    func CalculateSpendings()
}

//class Meeting: MeetingProtocol {
//    var name: String
//    var peopleAttending = [Person]()
//    var items = [Item]()
//    
//    init(name: String) {
//        self.name = name
//    }
//    
//    func AddPerson(person: Person) {
//        peopleAttending.append(person)
//    }
//    
//    func AddItem(item: Item) {
//        items.append(item)
//    }
//    
//    func CalculateSpendings() {
////        for person in peopleAttending{
////            for item in person.itemsBought!{
////                person.costs += item.cost
////                for user in item.users{
////                    user.uses += item.cost / Double(item.users.count)
////                }
////            }
////        }
//    }
//}
