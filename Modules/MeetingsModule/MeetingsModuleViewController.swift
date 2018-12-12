//
//  MeetingsModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class MeetingsModuleViewController: UIViewController, MeetingsModuleViewControllerProtocol,UITableViewDataSource, UITableViewDelegate {
    
    var presenter: MeetingsModulePresenterProtocol?
    var meetings: [Meeting]?
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        meetingsTable.delegate = self
        meetingsTable.dataSource = self
        
        titleLabel.font = EsteticsModel.titleLabelFont
        titleLabel.textColor = EsteticsModel.titleLabelTextColor
    //    presenter?.ViewWillAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.ViewWillAppear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //------------------------------------Table view section--------------------------------
    
    @IBOutlet weak var meetingsTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetings!.count
    }
    
    func SetTableData(meetings: [Meeting]) {
        self.meetings = meetings
        meetingsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetingCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = meetings![indexPath.row].name
        cell.textLabel?.textColor = EsteticsModel.inCellTextColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row != meetings?.count){
            presenter?.MeetingClicked(index: indexPath.row)
        }
    }
    

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "delete", handler: { (action, view, completionHandler) in
            self.presenter?.DeleteMeetingClicked(index: indexPath.row)
            completionHandler(true)
        })
        delete.image = #imageLiteral(resourceName: "delete_icon")
        delete.backgroundColor = EsteticsModel.deleteButtonBackgroungColor

        let configuration = UISwipeActionsConfiguration(actions: [delete])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

extension MeetingsModuleViewController{ // Button clicks handling methods
    
    @IBAction func AddButtonClicked(_ sender: Any) {
        presenter?.AddMeetingClicked()
    }
    
    @IBAction func DeleteButtonClicked(_ sender: Any) {
        let sender = sender as! UIButton
        let cell = sender.superview?.superview as! UITableViewCell
        let index = meetingsTable.indexPath(for: cell)?.row
        presenter?.DeleteMeetingClicked(index: index!)
    }
}
