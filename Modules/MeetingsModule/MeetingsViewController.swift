//
//  MeetingsModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class MeetingsViewController: UIViewController, MeetingsViewControllerProtocol, UIGestureRecognizerDelegate {
    
    var presenter: MeetingsPresenterProtocol?
    var meetings: [Meeting]?
    
    var activeMeetingsTable = UITableView()
    var closedMeetingsTable = UITableView()
    var settledMeetingsTable = UITableView()
    var tablesTable = [UITableView]()
    
    var activeEventsTableManager : ActiveEventsTableManager?
    var closedEventsTableManager : ClosedEventsTableManager?
    var settledEventsTableManager : SettledEventsTableManager?
    
    var activeMeetings = [Meeting]()
    var closedMeetings = [Meeting]()
    var settledMeetings = [Meeting]()
    
    var activeSectionButton = UIButton()
    var closedSectionButton = UIButton()
    var settledSectionButton = UIButton()
    
    var lastLongPressedCell: Int?
    
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

    func setTableData(meetings: [Meeting]) {
        self.meetings = meetings
        setDataSources()
        activeMeetingsTable.reloadData()
        closedMeetingsTable.reloadData()
        settledMeetingsTable.reloadData()
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
        activeEventsTableManager?.tableData = activeMeetings
        closedEventsTableManager?.tableData = closedMeetings
        settledEventsTableManager?.tableData = settledMeetings
    }
    
    func meetingClicked(meeintg: Meeting){
        presenter?.meetingClicked(meeting: meeintg)
    }
    
    func presentOptions(){
        let popUpVC = TableViewPopUp()
        popUpVC.delegate = self
        popUpVC.modalPresentationStyle = .overCurrentContext
        let options = ObjectOptions.meeting.getOptions()
        var optionNames = [String]()
        for option in options{
            optionNames.append(option.getName())
        }
        popUpVC.dataTable = optionNames
        self.present(popUpVC, animated: true) {}
    }
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer){
        if longPressGestureRecognizer.state == .began {
            let touchPoint = longPressGestureRecognizer.location(in: tablesTable[presentedSection])
            if let indexPath = tablesTable[presentedSection].indexPathForRow(at: touchPoint){
                tablesTable[presentedSection].cellForRow(at: indexPath)
                lastLongPressedCell = indexPath.row

                presenter?.cellLongPress(section: presentedSection, row: indexPath.row)
            }
        }
    }
    
    @objc func addButtonClicked(sender: UIButton) {
        presenter?.addMeetingClicked()
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

extension MeetingsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
        }
    }
}

extension MeetingsViewController: TableViewPopUpDelegate{
    func tableViewPopUp(_ tableViewPopUp: TableViewPopUp, cellSelectedAtIndex index: Int) {
        var clickedMeeting: Meeting
        switch presentedSection {
        case 0:
            clickedMeeting = activeMeetings[lastLongPressedCell!]
        case 1:
            clickedMeeting = closedMeetings[lastLongPressedCell!]
        case 2:
            clickedMeeting = settledMeetings[lastLongPressedCell!]
        default:
            clickedMeeting = activeMeetings[lastLongPressedCell!]
        }
        presenter?.deleteMeetingClicked(meeting: clickedMeeting)
    }
}
