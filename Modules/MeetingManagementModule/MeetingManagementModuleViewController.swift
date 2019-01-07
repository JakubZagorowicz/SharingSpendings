//
//  MeetingManagmentModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class MeetingManagementModuleViewController: UIViewController, MeetingManagementModuleViewControllerProtocol, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var itemsTable = UITableView(frame: .zero)
    var peopleTable = UITableView(frame: .zero)
    var debtsTable = UITableView(frame: .zero)
    @IBOutlet weak var meetingNameLabel: UILabel!
    
    var highlightBar = UIView(frame: .zero)
    var highligthBarLeftAnchor: NSLayoutConstraint?
    var collection: UICollectionView?
    var layout: UICollectionViewFlowLayout?
    var peopleButton = UIButton()
    var itemsButton = UIButton()
    var settlementButton = UIButton()
    var addButton = UIButton()
    let closeEventButton = UIButton(frame: .zero)
    let fromLabel = UILabel(frame: .zero)
    let howMuchLabel = UILabel(frame: .zero)
    let toLabel = UILabel(frame: .zero)

    var presenter: MeetingManagementModulePresenterProtcol?
    var personSectionData: [(Person, Double)]?
    var itemSectionData: [Item]?
    var debtsSectionData: [Debt]?
    var presentedSection: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    presenter?.ViewWillAppear()
        
        SetupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.ViewWillAppear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let sectionBeforeRotation = presentedSection
        self.collection?.reloadData()
//        self.collection?.scrollToItem(at: IndexPath(row: self.presentedSection, section: 0), at: [], animated: true)

//        layout?.invalidateLayout()
//
//        for cell in (collection?.visibleCells)!{
//            cell.setNeedsLayout()
//        }
//        super.viewWillTransition(to: size, with: coordinator)
//        coordinator.animate(alongsideTransition: nil) { (_) in
//            self.collection?.scrollToItem(at: IndexPath(row: self.presentedSection, section: 0), at: [], animated: true)
//        }
        DispatchQueue.main.async {
            self.collection?.scrollToItem(at: IndexPath(row: sectionBeforeRotation, section: 0), at: [], animated: true)
        }
    }
    
    func ShowPopUp(_with message: String){
        let popUp = ErrorPopUpViewController()
        popUp.message = message
        popUp.modalPresentationStyle = .overCurrentContext
        
        self.present(popUp, animated: true) {}
    }

    func SetMeetingName(name: String){
        meetingNameLabel.text = name
        meetingNameLabel.textColor = EsteticsModel.titleLabelTextColor
    }
    
    func SetAddItemButton(isEnabled: Bool){
        addButton.isEnabled = isEnabled
    }
    
    func AddButtonIsVisible(isVisible: Bool) {
        addButton.isHidden = !isVisible
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
            if personSectionData?.count == 0{
                return 1
            }
            return personSectionData!.count
        }
        else{
            if tableView == itemsTable{
                return itemSectionData!.count
            }
            else{
                return debtsSectionData!.count
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if(tableView == peopleTable){
            if personSectionData?.count == 0{
                cell.textLabel?.text = "Add some participants"
                cell.textLabel?.textColor = EsteticsModel.placeholderTextColor
                cell.backgroundColor = .clear
                cell.textLabel?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
            }
            else{
                cell = PersonTableViewCell()
                if let myCell = cell as? PersonTableViewCell{
                    myCell.SetUpCell(name: personSectionData![indexPath.row].0.name!)
                    myCell.SetBalance(balance: personSectionData![indexPath.row].1)
                }
            }
        }
        else{
            if tableView == itemsTable{
                cell.textLabel?.textColor = EsteticsModel.inCellTextColor
                cell.textLabel?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
                
                cell.textLabel?.text = itemSectionData![indexPath.row].name
            }
            else{
                if debtsSectionData?.count == 0{
                    
                }
                else{
                    cell = debtCell()
                    if let myCell = cell as? debtCell{
                        myCell.SetDebt(debt: debtsSectionData![indexPath.row])
                    }
                    
                }
            }
        }
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == peopleTable){
            if personSectionData?.count != 0{
                presenter?.PersonClicked(person: personSectionData![indexPath.row].0)
            }
        }
        if(tableView == itemsTable){
            presenter?.ItemClicked(item: itemSectionData![indexPath.row])
        }
    }
    
    func SetTableData(people: [(Person, Double)], items: [Item]) {
        personSectionData = people
        itemSectionData = items
        peopleTable.reloadData()
        itemsTable.reloadData()
    }
    
    func SetDebtsData(debts: [Debt]) {
        debtsSectionData = debts
        debtsTable.reloadData()
    }
    // ---------------------------------- Collection view section --------------------------------
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
       // let cell = UICollectionViewCell()
        let subviews = cell.subviews
        for subview in subviews{
            subview.removeFromSuperview()
        }
        if indexPath.row == 0{
            
            cell.addSubview(peopleTable)
            peopleTable.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            peopleTable.backgroundColor = .clear
        }
        else{
            if indexPath.row == 1{
                cell.addSubview(itemsTable)
                itemsTable.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
                itemsTable.backgroundColor = .clear
            }
            else{
                SetupSettlementCell(cell: cell)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func ScrollToSection(index: Int) {
        collection?.scrollToItem(at: IndexPath(item: index, section: 0), at: [], animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collection{
            highligthBarLeftAnchor!.constant = scrollView.contentOffset.x/3
            let visibleRect = CGRect(origin: collection!.contentOffset, size: collection!.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            let visibleIndexPath = collection!.indexPathForItem(at: visiblePoint)
            presentedSection = (visibleIndexPath?.row)!
            presenter?.SetPresentedSection(toIndex: presentedSection)
        }
    }
}

extension MeetingManagementModuleViewController{
    @IBAction func BackButtonClicked(_ sender: Any) {
        presenter?.BackButtonClicked()
    }
    
    @objc func PeopleButtonClick(sender: UIButton){
        presenter?.PeopleButtonClicked()
    }
    
    @objc func ItemsButtonClick(sender: UIButton){
        presenter?.ItemsButtonClicked()
    }
    @objc func SettlementButtonClick(sender: UIButton){
        presenter?.SettlementButtonClicked()
    }
    
    @objc func AddButtonClick(sender: UIButton){
        presenter?.AddButtonClicked()
    }
    
    @objc func CloseEventButtonClick(){
        presenter?.CloseEventButtonClicked()
    }
}
