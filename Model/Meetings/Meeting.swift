//
//  Meeting.swift
//  SharingSpendings
//
//  Created by User on 04.10.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation

extension Meeting {
    func calculateDebts(balances: [(Person, Double)]) -> [Debt]{
        var balances = balances
        var debts = [Debt]()
        var maxDebt: Double = 0
        var maxOwe: Double = 0
        var from = Person()
        var to = Person()
        var howMuch: Double = 0
        var condition = true
        while (balances.count > 0 && condition) {
            maxDebt = 0
            maxOwe = 0
            for (person, balance) in balances{
                if balance > maxOwe{
                    maxOwe = balance
                    to = person
                    
                }
                if balance < maxDebt{
                    maxDebt = balance
                    from = person
                }
            }
            if maxOwe < abs(maxDebt) {
                howMuch = maxOwe
                for index in stride(from: balances.count-1, through: 0, by: -1){
                    if balances[index].0 == from{
                        balances[index].1 += howMuch
                    }
                    if balances[index].0 == to{
                        balances.remove(at: index)
                        
                    }
                }
            }
            else{
                if abs(maxDebt) < maxOwe{
                howMuch = abs(maxDebt)
                    for index in stride(from: balances.count-1, through: 0, by: -1){
                        if balances[index].0 == to{
                            balances[index].1 -= howMuch
                        }
                        if balances[index].0 == from{
                            balances.remove(at: index)
                            
                        }
                    }
                    
                }
                else{
                    howMuch = abs(maxDebt)
                    for index in stride(from: balances.count-1, through: 0, by: -1) {
                        if balances[index].0 == to || balances[index].0 == from{
                            balances.remove(at: index)
                        }

                    }
                }
            }
            debts.append(Debt(from: from, to: to, howMuch: howMuch))
            condition = false
            for person in balances{
                if person.1 > 0.001{
                    condition = true
                }
            }
            // this function is ugly and I will look to simplify it in the future
        }

        return debts
    }
    func calculateBalance() -> [(Person, Double)]{
        var balanceArray = [(Person, Double)]()
        var balance: Double
        
        for person in peopleAttending!{
            balance = 0
            let person = person as! Person
            for item in person.itemsBought!{
                let item = item as! Item
                balance += item.cost
            }
            for item in person.itemsUsed!{
                let item = item as! Item
                balance -= item.cost/Double((item.usedBy?.count)!)
            }
            balanceArray.append((person, balance))
        }
        return balanceArray
    }
    
    static func getOptions() -> [SelectableOptions]{
        return [SelectableOptions.delete]
    }
}
