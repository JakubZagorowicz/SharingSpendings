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

    override func viewDidLoad() {
        super.viewDidLoad()

        meetingsTable.delegate = self
        meetingsTable.dataSource = self
        
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
        return meetings!.count+1
    }
    
    func SetTableData(meetings: [Meeting]) {
        self.meetings = meetings
        meetingsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row != meetings?.count){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeetingCell", for: indexPath) as UITableViewCell
            cell.textLabel?.text = meetings![indexPath.row].name
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddMeetingCell", for: indexPath) as UITableViewCell
            
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row != meetings?.count){
            presenter?.MeetingClicked(index: indexPath.row)
        }
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
