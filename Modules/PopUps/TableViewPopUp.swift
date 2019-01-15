//
//  CellOptionsPopUp.swift
//  SharingSpendings
//
//  Created by User on 08.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class TableViewPopUp: UIViewController{

    var optionsTable = UITableView()
    var delegate: TableViewPopUpDelegate?
    var backgroundButton = UIButton()
    var dataTable: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    func setupViewController(){
        backgroundButton.frame = self.view.frame
        backgroundButton.addTarget(self, action: #selector(backgroundClicked), for: .touchDown)
        view.addSubview(backgroundButton)
        
        view.addSubview(optionsTable)
        optionsTable.dataSource = self
        optionsTable.delegate = self
        optionsTable.alwaysBounceVertical = false
        
        optionsTable.translatesAutoresizingMaskIntoConstraints = false
        optionsTable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        optionsTable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        optionsTable.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        optionsTable.heightAnchor.constraint(equalToConstant: CGFloat(40*(dataTable?.count)!)).isActive = true
    }
    
    @objc func backgroundClicked(){
        self.dismiss(animated: true)
    }
}

extension TableViewPopUp: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataTable?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataTable![indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableViewPopUp(self, cellSelectedAtIndex: indexPath.row)
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
