//
//  PeopleTableManager.swift
//  SharingSpendings
//
//  Created by User on 09.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class PeopleTableManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableData: [(Person, Double)]?
    var cellSelectionCallback: (Person) -> Void
    
    init(cellSelectionCallback: @escaping (Person) -> Void) {
        self.cellSelectionCallback = cellSelectionCallback
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData!.count == 0 ? 1 : tableData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableData!.count == 0{
            EsteticsModel.setLabel(style: .inactiveTableCell, label: cell.textLabel!)
            cell.textLabel?.text = "There is no particicpants yet."
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
        }
        else{
            cell = PersonTableViewCell()
            if let myCell = cell as? PersonTableViewCell{
                myCell.setUpCell(name: tableData![indexPath.row].0.name!)
                myCell.setBalance(balance: tableData![indexPath.row].1)
                EsteticsModel.setLabel(style: .tableCell, label: myCell.textLabel!)
                myCell.backgroundColor = .clear
            }
            EsteticsModel.setLabel(style: .tableCell, label: cell.textLabel!)
            cell.textLabel?.text = tableData![indexPath.row].0.name
            cell.backgroundColor = .clear
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableData!.count != 0 {
            let selectedPerson = tableData![indexPath.row].0
            cellSelectionCallback(selectedPerson)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EsteticsModel.cellHeight
    }
}
