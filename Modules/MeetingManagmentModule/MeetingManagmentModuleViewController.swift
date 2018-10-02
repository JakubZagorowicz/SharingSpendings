//
//  MeetingManagmentModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class MeetingManagmentModuleViewController: UIViewController, MeetingManagementModuleViewControllerProtocol, UITableViewDelegate, UITableViewDataSource {
    
    func SetMessageLabel(message: String) {
        MessageLabel.text = message
    }
    @IBOutlet weak var MessageLabel: UILabel!
    
    func SetBalance(for index: Int, balance: Double) {
        let cell : PersonTableViewCell = meetingTable.cellForRow(at: IndexPath(row: index, section: 0)) as! PersonTableViewCell
        cell.balanceLabel.text = String(format: "%.02f", balance)
        if balance < 0{
            cell.balanceLabel.textColor = UIColor.red
        }
        else{
            cell.balanceLabel.textColor = UIColor.green
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "People"
        }
        else{
            return "Items"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return personSectionData!.count + 1
        }
        else{
            return itemSectionData!.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if(indexPath.section == 0){
            if(indexPath.row != personSectionData?.count){
                
                cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonTableViewCell
                
                cell.textLabel?.text = personSectionData![indexPath.row].name
            }
            else{
                cell = tableView.dequeueReusableCell(withIdentifier: "AddPersonCell", for: indexPath) as UITableViewCell
            }
        }
        else{
            if(indexPath.row != itemSectionData?.count){
                cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as UITableViewCell
                cell.textLabel?.text = itemSectionData![indexPath.row].name
            }
            else{
                cell = tableView.dequeueReusableCell(withIdentifier: "AddItemCell", for: indexPath) as UITableViewCell
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0 && indexPath.row != personSectionData?.count){
            presenter?.PersonClicked(person: personSectionData![indexPath.row])
        }
        if(indexPath.section == 1 && indexPath.row != itemSectionData?.count){
            presenter?.ItemClicked(item: itemSectionData![indexPath.row])
        }
    }

    @IBOutlet weak var meetingTable: UITableView!
    var presenter: MeetingManagmentModulePresenterProtcol?
    var personSectionData: [Person]?
    var itemSectionData: [Item]?
    
    func SetTableData(people: [Person], items: [Item]) {
        personSectionData = people
        itemSectionData = items
        meetingTable.reloadData()
    }
    
    @IBAction func AddPersonClicked(_ sender: Any) {
        presenter?.AddPersonClicked()
    }
    @IBAction func DeletePersonClicked(_ sender: Any) {
        let sender = sender as! UIButton
        let cell = sender.superview?.superview as! UITableViewCell
        let index = meetingTable.indexPath(for: cell)?.row
        presenter?.DeletePersonClicked(person: personSectionData![index!])
    }
    @IBAction func AddItemClicked(_ sender: Any) {
        presenter?.AddItemClicked()
    }
    
    @IBAction func DeleteItemClicked(_ sender: Any) {
        let sender = sender as! UIButton
        let cell = sender.superview?.superview as! UITableViewCell
        let index = meetingTable.indexPath(for: cell)?.row
        presenter?.DeleteItemClicked(item: itemSectionData![index!])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    //    presenter?.ViewWillAppear()
        
        meetingTable.delegate = self
        meetingTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.ViewWillAppear()
    }
    
    @IBAction func BackButtonClicked(_ sender: Any) {
        presenter?.BackButtonClicked()
    }
}

