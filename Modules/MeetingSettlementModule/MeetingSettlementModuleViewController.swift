//
//  MeetingSettlementModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 03.10.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class MeetingSettlementModuleViewController: UIViewController, MeetingSettlementModuleViewControllerProtocol, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var topMiddleLabel: UILabel!
    @IBOutlet weak var topRightLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var debtsTableView: UITableView!
    
    var closeEventButton = UIButton(frame: .zero)
    
    var debts: [Debt]?
    
    var presenter: MeetingSettlementModulePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        debtsTableView.delegate = self
        debtsTableView.dataSource = self
        
        titleLabel.font = EsteticsModel.titleLabelFont
        titleLabel.textColor = EsteticsModel.titleLabelTextColor
        
        SetLabels()
        SetButton()
        
        presenter?.ViewWillAppear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func SetLabels(){
        let labels = [topLeftLabel,topRightLabel,topMiddleLabel]
        for label in labels{
            label?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize+2)
            label?.textColor = EsteticsModel.inCellTextColor
        }
        topLeftLabel.text = "From:"
        topMiddleLabel.text = "Amount:"
        topRightLabel.text = "To:"
    }
    
    func SetButton(){
        closeEventButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeEventButton)
        closeEventButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        closeEventButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        closeEventButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        closeEventButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeEventButton.backgroundColor = UIColor(red: 0, green: 143, blue: 0)
        closeEventButton.setTitle("Close event", for: .normal)
        closeEventButton.setTitleColor(EsteticsModel.inCellTextColor, for: .normal)
        
        view.bringSubviewToFront(closeEventButton)
    }
    
    @IBAction func BackButtonClick(_ sender: Any) {
        presenter?.BackButtonClicked()
    }
    
    func SetTableViewData(debts: [Debt]) {
        self.debts = debts
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableCell(withIdentifier: "DebtsHeaderCell")
//        return header
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40.0
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewModel.cellHeight
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (debts?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "debtCell", for: indexPath) as! debtCell
        cell.SetDebt(debt: debts![indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
}
