//
//  MeetingSettlementModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 03.10.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class MeetingSettlementModuleViewController: UIViewController, MeetingSettlementModuleViewControllerProtocol, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var debtsTableView: UITableView!
    
    var debts: [Debt]?
    
    var presenter: MeetingSettlementModulePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        debtsTableView.delegate = self
        debtsTableView.dataSource = self
        
        presenter?.ViewWillAppear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BackButtonClick(_ sender: Any) {
        presenter?.BackButtonClicked()
    }
    
    func SetTableViewData(debts: [Debt]) {
        self.debts = debts
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "DebtsHeaderCell")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
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
}
