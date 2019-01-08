//
//  MeetingsModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class MeetingsViewController: UIViewController, MeetingsViewControllerProtocol,UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    var presenter: MeetingsPresenterProtocol?
    var meetings: [Meeting]?
    
    var activeMeetingsTable = UITableView()
    var closedMeetingsTable = UITableView()
    var settledMeetingsTable = UITableView()
    var tablesTable = [UITableView]()
    
    var activeMeetings = [Meeting]()
    var closedMeetings = [Meeting]()
    var settledMeetings = [Meeting]()
    
    var activeSectionButton = UIButton()
    var closedSectionButton = UIButton()
    var settledSectionButton = UIButton()
    
    var addButton = UIButton()
    
    var highlightBar = UIView()
    var highligthBarLeftAnchor: NSLayoutConstraint?

    var layout : UICollectionViewFlowLayout?
    var collection : UICollectionView?
    
    var presentedSection: Int = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    //    presenter?.ViewWillAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let sectionBeforeRotation = presentedSection
        self.collection?.reloadData()
        DispatchQueue.main.async {
            self.collection?.scrollToItem(at: IndexPath(row: sectionBeforeRotation, section: 0), at: [], animated: false)
        }
    }
    
    //------------------------------------Table view section--------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == activeMeetingsTable{
            return activeMeetings.count == 0 ? 1 : activeMeetings.count
        }
        if tableView == closedMeetingsTable{
            return closedMeetings.count == 0 ? 1 : closedMeetings.count
        }
        if tableView == settledMeetingsTable{
            return settledMeetings.count == 0 ? 1 : settledMeetings.count
        }
        return 0
    }
    
    func setTableData(meetings: [Meeting]) {
        self.meetings = meetings
        setDataSources()
        activeMeetingsTable.reloadData()
        closedMeetingsTable.reloadData()
        settledMeetingsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var dataSource: [Meeting]
        var noEventsMessage: String
        if tableView == activeMeetingsTable{
            dataSource = activeMeetings
            noEventsMessage = "There is no active events."
        }
        else{
            if tableView == closedMeetingsTable{
                dataSource = closedMeetings
                noEventsMessage = "There is no closed events."
            }
            else{
                dataSource = settledMeetings
                noEventsMessage = "There is no settled events."
            }
        }
        if dataSource.count == 0{
            cell.textLabel?.text = noEventsMessage
            cell.textLabel?.textColor = EsteticsModel.placeholderTextColor
        }
        else{
            cell.textLabel?.text = dataSource[indexPath.row].name
            cell.textLabel?.textColor = EsteticsModel.inCellTextColor
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
        cell.backgroundColor = .clear
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
            presenter?.meetingClicked(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewModel.cellHeight
    }
    
    func setDataSources(){
        activeMeetings = [Meeting]()
        closedMeetings = [Meeting]()
        settledMeetings = [Meeting]()
        for meeting in meetings!{
            if meeting.status == "active" || meeting.status == nil{
                activeMeetings.append(meeting)
            }
            if meeting.status == "closed"{
                closedMeetings.append(meeting)
            }
            if meeting.status == "settled"{
                closedMeetings.append(meeting)
            }
        }
    }
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer){
        if longPressGestureRecognizer.state == .ended {
            let touchPoint = longPressGestureRecognizer.location(in: tablesTable[presentedSection])
            if let indexPath = tablesTable[presentedSection].indexPathForRow(at: touchPoint){
                tablesTable[presentedSection].cellForRow(at: indexPath)
                presenter?.cellLongPress(section: presentedSection, row: indexPath.row)
            }

        }
    }
    
//--------------------- collection view section -------------------------
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let subviews = cell.subviews
        for subview in subviews{
            subview.removeFromSuperview()
        }
        if indexPath.row == 0{
            cell.addSubview(activeMeetingsTable)
            activeMeetingsTable.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            activeMeetingsTable.backgroundColor = .clear
        }
        else{
            if indexPath.row == 1{
                cell.addSubview(closedMeetingsTable)
                closedMeetingsTable.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
                closedMeetingsTable.backgroundColor = .clear
            }
            else{
                cell.addSubview(settledMeetingsTable)
                settledMeetingsTable.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
                settledMeetingsTable.backgroundColor = .clear
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func scrollToSection(index: Int) {
        collection?.scrollToItem(at: IndexPath(item: index, section: 0), at: [], animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collection{
            highligthBarLeftAnchor!.constant = scrollView.contentOffset.x/3
            let visibleRect = CGRect(origin: collection!.contentOffset, size: collection!.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            let visibleIndexPath = collection!.indexPathForItem(at: visiblePoint)
            presentedSection = (visibleIndexPath?.row)!
//            presenter?.SetPresentedSection(toIndex: presentedSection)
        }
    }
}

extension MeetingsViewController{ // Button clicks handling methods
    @objc func addButtonClicked(sender: UIButton) {
        presenter?.addMeetingClicked()
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {

    }
    
    @objc func sectionButtonClicked(sender: UIButton){
        let index: Int
        if sender == activeSectionButton{
            index = 0
        }
        else{
            if sender == closedSectionButton{
                index = 1
            }
            else{
                index = 2
            }
        }
        presenter?.sectionButtonClicked(sectionIndex: index)
    }
}
