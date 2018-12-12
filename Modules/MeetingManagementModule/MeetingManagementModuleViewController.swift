//
//  MeetingManagmentModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class MeetingManagementModuleViewController: UIViewController, MeetingManagementModuleViewControllerProtocol, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ItemsLabel: UILabel!
    @IBOutlet weak var PeopleLabel: UILabel!
    @IBOutlet weak var SettleUpButton: UIButton!
    @IBOutlet weak var itemsTable: UITableView!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var peopleTable: UITableView!
    @IBOutlet weak var meetingNameLabel: UILabel!
    @IBOutlet weak var addItemButton: UIButton!
    
    var presenter: MeetingManagementModulePresenterProtcol?
    var personSectionData: [(Person, Double)]?
    var itemSectionData: [Item]?

    override func viewDidLoad() {
        super.viewDidLoad()

    //    presenter?.ViewWillAppear()
        
        peopleTable.delegate = self
        peopleTable.dataSource = self
        itemsTable.delegate = self
        itemsTable.dataSource = self

        ItemsLabel.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize+2)
        PeopleLabel.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize+2)
        meetingNameLabel.font = EsteticsModel.titleLabelFont
        meetingNameLabel.textColor = EsteticsModel.titleLabelTextColor
        
      //  SettleUpButton.translatesAutoresizingMaskIntoConstraints = true
     //   SettleUpButton.frame = CGRect(x: SettleUpButton.frame.minX, y: SettleUpButton.frame.minY, width: SettleUpButton.frame.width, height: TableViewModel.cellHeight)
       // SettleUpButton.frame = .zero
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.ViewWillAppear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        peopleTable.reloadData()
    }
    
    func SetMessageLabel(message: String) {
        MessageLabel.text = message
        MessageLabel.textColor = EsteticsModel.messageLabelTextColor
    }

    func SetMeetingName(name: String){
        meetingNameLabel.text = name
        meetingNameLabel.textColor = EsteticsModel.titleLabelTextColor
        
    }
    
    func SetAddItemButton(isEnabled: Bool){
        addItemButton.isEnabled = isEnabled
    }
    
    func SetSettleUpButton(isEnabled: Bool){
        SettleUpButton.isEnabled = isEnabled
    }

    
    // -----------------------------------TableView section-------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == peopleTable){
            return personSectionData!.count
        }
        else{
            return itemSectionData!.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if(tableView == peopleTable){

            cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
            let myCell = cell as! PersonTableViewCell
            myCell.textLabel?.text = personSectionData![indexPath.row].0.name
            myCell.textLabel?.textColor = EsteticsModel.inCellTextColor
            myCell.textLabel?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
            myCell.SetBalance(balance: personSectionData![indexPath.row].1)
            
        }
        else{
    
            cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as UITableViewCell
            cell.textLabel?.textColor = EsteticsModel.inCellTextColor
            cell.textLabel?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)

            cell.textLabel?.text = itemSectionData![indexPath.row].name
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == peopleTable){
            presenter?.PersonClicked(person: personSectionData![indexPath.row].0)
        }
        if(tableView == itemsTable){
            presenter?.ItemClicked(item: itemSectionData![indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "edit") { (edit, view, completionHandler) in
            if tableView == self.peopleTable {
                self.presenter?.PersonClicked(person: self.personSectionData![indexPath.row].0)
            }
            else{
                self.presenter?.ItemClicked(item: self.itemSectionData![indexPath.row])
            }
            completionHandler(true)
        }
        edit.image = #imageLiteral(resourceName: "edit_icon")
        edit.backgroundColor = EsteticsModel.editButtonBackgroundColor
        
        let delete = UIContextualAction(style: .normal, title: "delete") { (delete, view, completionHandler) in
            if tableView == self.peopleTable {
                self.presenter?.DeletePersonClicked(person: self.personSectionData![indexPath.row].0)
            }
            else{
                self.presenter?.DeleteItemClicked(item: self.itemSectionData![indexPath.row])
            }
            completionHandler(true)
        }
        delete.image = #imageLiteral(resourceName: "delete_icon")
        delete.backgroundColor = EsteticsModel.deleteButtonBackgroungColor
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
    
    func SetTableData(people: [(Person, Double)], items: [Item]) {
        personSectionData = people
        itemSectionData = items
        peopleTable.reloadData()
        itemsTable.reloadData()
    }


}

extension MeetingManagementModuleViewController{
    @IBAction func SettleUpButtonClicked(_ sender: Any) {
        presenter?.SettleUpButtonClicked()
    }

    @IBAction func BackButtonClicked(_ sender: Any) {
        presenter?.BackButtonClicked()
    }
    
    @IBAction func AddPersonClicked(_ sender: Any) {
        presenter?.AddPersonClicked()
    }
    
    @IBAction func AddItemClicked(_ sender: Any) {
        presenter?.AddItemClicked()
    }
}
