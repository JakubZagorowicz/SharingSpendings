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

    var tableView = UITableView()
    var delegate: TableViewPopUpDelegate?
    var backgroundButton = UIButton()
    var cancelButton =  UIButton()
    var dataTable: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    func setupViewController(){
        backgroundButton.frame = self.view.frame
        backgroundButton.addTarget(self, action: #selector(backgroundClicked), for: .touchDown)
        backgroundButton.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.7)
        view.addSubview(backgroundButton)
        view.addSubview(cancelButton)
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.alwaysBounceVertical = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: EsteticsModel.cellHeight*CGFloat((dataTable?.count)!)).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        
        cancelButton.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cancelButton.backgroundColor = UIColor.gray
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(EsteticsModel.inCellTextColor, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
    
    @objc func backgroundClicked(){
        self.dismiss(animated: true)
    }
    
    @objc func cancelButtonClicked(sender: UIButton){
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
        EsteticsModel.setLabel(style: .whiteBackgroundCell, label: cell.textLabel!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: false)
        delegate?.tableViewPopUp(self, cellSelectedAtIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EsteticsModel.cellHeight
    }
}
