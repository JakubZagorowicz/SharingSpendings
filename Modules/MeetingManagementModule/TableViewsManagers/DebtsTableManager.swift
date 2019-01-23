//
//  DebtsTableManager.swift
//  SharingSpendings
//
//  Created by User on 09.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class DebtsTableManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableData: [(Debt, Bool)]?
    var cellSelectionCallback: (Int) -> Void
    
    init(cellSelectionCallback: @escaping (Int) -> Void) {
        self.cellSelectionCallback = cellSelectionCallback
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData!.count == 0 ? 1 : tableData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableData!.count == 0{
            EsteticsModel.setLabel(style: .inactiveTableCell, label: cell.textLabel!)
            cell.textLabel?.text = "There is no debts."
            cell.backgroundColor = .clear
        }
        else{
            cell = DebtCell()
            if let myCell = cell as? DebtCell{
                myCell.setDebt(debt: tableData![indexPath.row].0)
                if tableData![indexPath.row].1{
                    EsteticsModel.setLabel(style: .inactiveTableCell, label: myCell.fromLabel)
                    EsteticsModel.setLabel(style: .inactiveTableCell, label: myCell.toLabel)
                    EsteticsModel.setLabel(style: .inactiveTableCell, label: myCell.howMuchLabel)
                }
                myCell.backgroundColor = .clear
            }
        }
        cell.selectionStyle = .none
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
            cellSelectionCallback(indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EsteticsModel.cellHeight
    }
}
