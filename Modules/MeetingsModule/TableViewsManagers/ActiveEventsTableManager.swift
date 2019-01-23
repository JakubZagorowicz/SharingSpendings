//
//  ActiveEventsTableDelegate.swift
//  SharingSpendings
//
//  Created by User on 09.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class ActiveEventsTableManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableData: [Meeting]?
    var cellSelectionCallback: (Meeting) -> Void
    
    init(cellSelectionCallback: @escaping (Meeting) -> Void) {
        self.cellSelectionCallback = cellSelectionCallback

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData!.count == 0 ? 1 : tableData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tableData!.count == 0{
            EsteticsModel.setLabel(style: .inactiveTableCell, label: cell.textLabel!)
            cell.textLabel?.text = "There is no active events."
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
        }
        else{
            EsteticsModel.setLabel(style: .tableCell, label: cell.textLabel!)
            cell.textLabel?.text = tableData![indexPath.row].name
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
            let selectedEvent = tableData![indexPath.row]
            cellSelectionCallback(selectedEvent)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EsteticsModel.cellHeight
    }
}
