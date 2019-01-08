//
//  MeetingManagementViewControllerSetup.swift
//  SharingSpendings
//
//  Created by User on 03.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

extension MeetingManagementViewController{
    func setupView(){
        peopleTable.delegate = self
        peopleTable.dataSource = self
        itemsTable.delegate = self
        itemsTable.dataSource = self
        debtsTable.delegate = self
        debtsTable.dataSource = self
        
        meetingNameLabel.font = EsteticsModel.titleLabelFont
        meetingNameLabel.textColor = EsteticsModel.titleLabelTextColor
        
        view.addSubview(highlightBar)
        view.addSubview(addButton)
        view.addSubview(peopleButton)
        view.addSubview(itemsButton)
        view.addSubview(settlementButton)
        
        let backgroundMenuView = UIView(frame: .zero)
        backgroundMenuView.backgroundColor = UIColor(rgb: 0x244C59)
        view.addSubview(backgroundMenuView)
        view.sendSubviewToBack(backgroundMenuView)
        backgroundMenuView.translatesAutoresizingMaskIntoConstraints = false
        backgroundMenuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundMenuView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundMenuView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundMenuView.bottomAnchor.constraint(equalTo: highlightBar.bottomAnchor).isActive = true
        
        let whiteLine = UIView()
        whiteLine.backgroundColor = .gray
        view.addSubview(whiteLine)
        whiteLine.translatesAutoresizingMaskIntoConstraints = false
        whiteLine.centerYAnchor.constraint(equalTo: highlightBar.centerYAnchor).isActive = true
        whiteLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteLine.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        whiteLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addButton.setImage(UIImage(named: "add_button2"), for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        peopleButton.setTitle("Participants", for: .normal)
        peopleButton.titleLabel?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize+2)
        peopleButton.setTitleColor(EsteticsModel.inCellTextColor, for: .normal)
        peopleButton.translatesAutoresizingMaskIntoConstraints = false
        peopleButton.topAnchor.constraint(equalTo: meetingNameLabel.bottomAnchor, constant: 20).isActive = true
        peopleButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        peopleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        peopleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        peopleButton.addTarget(self, action: #selector(peopleButtonClick), for: .touchUpInside)
        
        itemsButton.setTitle("Expenses", for: .normal)
        itemsButton.titleLabel?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize+2)
        itemsButton.setTitleColor(EsteticsModel.inCellTextColor, for: .normal)
        itemsButton.translatesAutoresizingMaskIntoConstraints = false
        itemsButton.topAnchor.constraint(equalTo: meetingNameLabel.bottomAnchor, constant: 20).isActive = true
        itemsButton.leftAnchor.constraint(equalTo: peopleButton.rightAnchor).isActive = true
        itemsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        itemsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        itemsButton.addTarget(self, action: #selector(itemsButtonClicked), for: .touchUpInside)
        
        settlementButton.setTitle("Settlement", for: .normal)
        settlementButton.titleLabel?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize+2)
        settlementButton.setTitleColor(EsteticsModel.inCellTextColor, for: .normal)
        settlementButton.translatesAutoresizingMaskIntoConstraints = false
        settlementButton.topAnchor.constraint(equalTo: meetingNameLabel.bottomAnchor, constant: 20).isActive = true
        settlementButton.leftAnchor.constraint(equalTo: itemsButton.rightAnchor).isActive = true
        settlementButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        settlementButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        settlementButton.addTarget(self, action: #selector(settlementButtonClicked), for: .touchUpInside)
        
        highlightBar.backgroundColor = .white
        highlightBar.translatesAutoresizingMaskIntoConstraints = false
        highlightBar.topAnchor.constraint(equalTo: peopleButton.bottomAnchor, constant: 10).isActive = true
        highligthBarLeftAnchor = highlightBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        highligthBarLeftAnchor?.isActive = true
        highlightBar.widthAnchor.constraint(equalTo: peopleButton.widthAnchor, multiplier: 1).isActive = true
        highlightBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.bringSubviewToFront(highlightBar)
        
        layout = UICollectionViewFlowLayout()
        layout?.scrollDirection = .horizontal
        layout?.minimumLineSpacing = 0
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout!)
        collection?.isPagingEnabled = true
        collection?.backgroundColor = .clear
        collection?.dataSource = self
        collection?.delegate = self
        collection?.alwaysBounceHorizontal = true
        view.addSubview(collection!)
        collection?.translatesAutoresizingMaskIntoConstraints = false
        collection?.topAnchor.constraint(equalTo: highlightBar.bottomAnchor, constant: 0).isActive = true
        collection?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collection?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collection?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collection?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        view.bringSubviewToFront(addButton)
    }
    
    func setupSettlementCell(cell: UICollectionViewCell){
        let labelHeigth : CGFloat = 25
        fromLabel.text = "From:"
        howMuchLabel.text = "Amount:"
        toLabel.text = "To:"

        cell.addSubview(fromLabel)
        cell.addSubview(howMuchLabel)
        cell.addSubview(toLabel)
        let labels = [fromLabel,howMuchLabel,toLabel]
        for label in labels{
            label.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize+2)
            label.textColor = EsteticsModel.inCellTextColor
        }
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        fromLabel.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 10).isActive = true
        fromLabel.heightAnchor.constraint(equalToConstant: labelHeigth).isActive = true
        fromLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10).isActive = true
        fromLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.3).isActive = true
        
        howMuchLabel.translatesAutoresizingMaskIntoConstraints = false
        howMuchLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10).isActive = true
        howMuchLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        howMuchLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.3).isActive = true
        howMuchLabel.heightAnchor.constraint(equalToConstant: labelHeigth).isActive = true
        
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        toLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10).isActive = true
        toLabel.heightAnchor.constraint(equalToConstant: labelHeigth).isActive = true
        toLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.3).isActive = true
        toLabel.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: 0).isActive = true

        debtsTable.backgroundColor = .clear
        cell.addSubview(debtsTable)
        cell.addSubview(closeEventButton)
        
        debtsTable.translatesAutoresizingMaskIntoConstraints = false
        debtsTable.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 10).isActive = true
        debtsTable.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        debtsTable.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        debtsTable.bottomAnchor.constraint(equalTo: closeEventButton.topAnchor, constant: 20).isActive = true
        
        closeEventButton.setTitle("Close event", for: .normal)
        closeEventButton.backgroundColor = .red
        closeEventButton.translatesAutoresizingMaskIntoConstraints = false
        closeEventButton.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -30).isActive = true
        closeEventButton.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        closeEventButton.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.8).isActive = true
        closeEventButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeEventButton.addTarget(self, action: #selector(closeEventButtonClicked), for: .touchUpInside)
    }
}
