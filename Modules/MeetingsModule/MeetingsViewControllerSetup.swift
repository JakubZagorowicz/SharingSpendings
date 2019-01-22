//
//  MeetingsModuleViewControllerSetup.swift
//  SharingSpendings
//
//  Created by User on 07.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import UIKit

extension MeetingsViewController{
    func setupView(){
        titleLabel.font = EsteticsModel.titleLabelFont
        titleLabel.textColor = EsteticsModel.titleLabelTextColor
        
        activeEventsTableManager = ActiveEventsTableManager(cellSelectionCallback: meetingClicked)
        closedEventsTableManager = ClosedEventsTableManager(cellSelectionCallback: meetingClicked)
        settledEventsTableManager = SettledEventsTableManager(cellSelectionCallback: meetingClicked)
        
        activeMeetingsTable.dataSource = activeEventsTableManager
        activeMeetingsTable.delegate = activeEventsTableManager
        closedMeetingsTable.dataSource = closedEventsTableManager
        closedMeetingsTable.delegate = closedEventsTableManager
        settledMeetingsTable.dataSource = settledEventsTableManager
        settledMeetingsTable.delegate = settledEventsTableManager
        
        view.addSubview(addButton)
        addButton.setImage(UIImage(named: "add_button2"), for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        menuButton = UIButton()
        menuButton?.setImage(UIImage(named: "menu_icon"), for: .normal)
        view.addSubview(menuButton!)
        menuButton?.translatesAutoresizingMaskIntoConstraints = false
        menuButton?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        menuButton?.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        menuButton?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        menuButton?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        menuButton?.addTarget(self, action: #selector(menuButtonClicked(_:)), for: .touchUpInside)
        
        gestureScreenEdgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(gestureScreenEdgePan(_:)))
        gestureScreenEdgePan?.edges = .left
        view.addGestureRecognizer(gestureScreenEdgePan!)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gesturePan(_:)))
        
        slideMenu = SlideInMenu()
        view.addSubview(slideMenu!)
        slideMenu?.translatesAutoresizingMaskIntoConstraints = false
        slideMenu?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        constraintMenuWidth = slideMenu?.widthAnchor.constraint(equalToConstant: 330)
        constraintMenuWidth?.isActive = true
        let constant = -(constraintMenuWidth?.constant)!
        constraintMenuLeft = slideMenu?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant)
        constraintMenuLeft?.isActive = true
        slideMenu?.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        slideMenu?.addGestureRecognizer(panGestureRecognizer!)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureTap(_:)))
        
        viewBlack = UIView()
        viewBlack?.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.7)
        view.addSubview(viewBlack!)
        viewBlack?.translatesAutoresizingMaskIntoConstraints = false
        viewBlack?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewBlack?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewBlack?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewBlack?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewBlack?.isHidden = true
        viewBlack?.addGestureRecognizer(tapGestureRecognizer!)
        
        view.addSubview(activeSectionButton)
        view.addSubview(closedSectionButton)
        view.addSubview(settledSectionButton)
        view.addSubview(highlightBar)
        
        activeSectionButton.setTitle("Active", for: .normal)
        activeSectionButton.titleLabel?.font = UIFont.systemFont(ofSize: EsteticsModel.headerLabelFontSize)
        activeSectionButton.setTitleColor(EsteticsModel.inCellTextColor, for: .normal)
        activeSectionButton.translatesAutoresizingMaskIntoConstraints = false
        activeSectionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        activeSectionButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        activeSectionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        activeSectionButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        activeSectionButton.addTarget(self, action: #selector(sectionButtonClicked), for: .touchUpInside)
        
        closedSectionButton.setTitle("Closed", for: .normal)
        closedSectionButton.titleLabel?.font = UIFont.systemFont(ofSize: EsteticsModel.headerLabelFontSize)
        closedSectionButton.setTitleColor(EsteticsModel.inCellTextColor, for: .normal)
        closedSectionButton.translatesAutoresizingMaskIntoConstraints = false
        closedSectionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        closedSectionButton.leftAnchor.constraint(equalTo: activeSectionButton.rightAnchor).isActive = true
        closedSectionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        closedSectionButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closedSectionButton.addTarget(self, action: #selector(sectionButtonClicked), for: .touchUpInside)
        
        settledSectionButton.setTitle("Settled", for: .normal)
        settledSectionButton.titleLabel?.font = UIFont.systemFont(ofSize: EsteticsModel.headerLabelFontSize)
        settledSectionButton.setTitleColor(EsteticsModel.inCellTextColor, for: .normal)
        settledSectionButton.translatesAutoresizingMaskIntoConstraints = false
        settledSectionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        settledSectionButton.leftAnchor.constraint(equalTo: closedSectionButton.rightAnchor).isActive = true
        settledSectionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        settledSectionButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        settledSectionButton.addTarget(self, action: #selector(sectionButtonClicked), for: .touchUpInside)
        
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
        
        highlightBar.backgroundColor = .white
        highlightBar.translatesAutoresizingMaskIntoConstraints = false
        highlightBar.topAnchor.constraint(equalTo: activeSectionButton.bottomAnchor, constant: 10).isActive = true
        highligthBarLeftAnchor = highlightBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        highligthBarLeftAnchor?.isActive = true
        highlightBar.widthAnchor.constraint(equalTo: activeSectionButton.widthAnchor, multiplier: 1).isActive = true
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
        collection?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collection?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 1).isActive = true
        collection?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressRecognizer.delegate = self
        longPressRecognizer.minimumPressDuration = 1.0
        view.addGestureRecognizer(longPressRecognizer)
        
        tablesTable = [activeMeetingsTable, closedMeetingsTable, settledMeetingsTable]
        
        view.bringSubviewToFront(addButton)
        view.bringSubviewToFront(viewBlack!)
        view.bringSubviewToFront(slideMenu!)
    }
}
