//
//  ItemsTableManager.swift
//  SharingSpendings
//
//  Created by User on 09.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class ItemsTableManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableData: [Item]?
    var cellSelectionCallback: (Item) -> Void
    
    init(cellSelectionCallback: @escaping (Item) -> Void) {
        self.cellSelectionCallback = cellSelectionCallback
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData!.count == 0 ? 1 : tableData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tableData!.count == 0{
            EsteticsModel.setLabel(style: .inactiveTableCell, label: cell.textLabel!)
            cell.textLabel?.text = "There is no expenses yet."
            cell.backgroundColor = .clear
        }
        else{
            EsteticsModel.setLabel(style: .tableCell, label: cell.textLabel!)
            cell.textLabel?.text = tableData![indexPath.row].name
            cell.backgroundColor = .clear
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
            let selectedItem = tableData![indexPath.row]
            cellSelectionCallback(selectedItem)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EsteticsModel.cellHeight
    }
}
