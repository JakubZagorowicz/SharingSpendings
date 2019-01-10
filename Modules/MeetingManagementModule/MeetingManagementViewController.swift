//
//  MeetingManagmentModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class MeetingManagementViewController: UIViewController, MeetingManagementViewControllerProtocol{

    var itemsTable = UITableView(frame: .zero)
    var peopleTable = UITableView(frame: .zero)
    var debtsTable = UITableView(frame: .zero)
    
    var peopleTableManager: PeopleTableManager?
    var itemsTableManager: ItemsTableManager?
    var debtsTableManager: DebtsTableManager?
    
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

    var presenter: MeetingManagementPresenterProtcol?
    var personSectionData: [(Person, Double)]?
    var itemSectionData: [Item]?
    var debtsSectionData: [Debt]?
    var presentedSection: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let sectionBeforeRotation = presentedSection
        self.collection?.reloadData()
        DispatchQueue.main.async {
            self.collection?.scrollToItem(at: IndexPath(row: sectionBeforeRotation, section: 0), at: [], animated: true)
        }
    }
    
    func showMessagePopUp(message: String){
        let popUp = ErrorPopUpViewController()
        popUp.message = message
        popUp.modalPresentationStyle = .overCurrentContext
        
        self.present(popUp, animated: true) {}
    }

    func setMeetingName(name: String){
        meetingNameLabel.text = name
        meetingNameLabel.textColor = EsteticsModel.titleLabelTextColor
    }
    
    func setAddItemButton(isEnabled: Bool){
        addButton.isEnabled = isEnabled
    }
    
    func addButtonIsVisible(isVisible: Bool) {
        addButton.isHidden = !isVisible
    }
    
    func setTableData(people: [(Person, Double)], items: [Item]) {
        personSectionData = people
        itemSectionData = items
        peopleTableManager?.tableData = personSectionData
        itemsTableManager?.tableData = itemSectionData
        peopleTable.reloadData()
        itemsTable.reloadData()
    }
    
    func setDebtsData(debts: [Debt]) {
        debtsSectionData = debts
        debtsTableManager?.tableData = debtsSectionData
        debtsTable.reloadData()
    }
    
    func personClicked(person: Person){
        presenter?.personClicked(person: person)
    }
    
    func itemClicked(item: Item){
        presenter?.itemClicked(item: item)
    }
    
    func debtClicked(debt: Debt){
        
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        presenter?.backButtonClicked()
    }
    
    @objc func peopleButtonClick(sender: UIButton){
        presenter?.peopleButtonClicked()
    }
    
    @objc func itemsButtonClicked(sender: UIButton){
        presenter?.itemsButtonClicked()
    }
    
    @objc func settlementButtonClicked(sender: UIButton){
        presenter?.settlementButtonClicked()
    }
    
    @objc func addButtonClicked(sender: UIButton){
        presenter?.addButtonClicked()
    }
    
    @objc func closeEventButtonClicked(){
        presenter?.closeEventButtonClicked()
    }
}

extension MeetingManagementViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
                setupSettlementCell(cell: cell)
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
            presenter?.setPresentedSection(toIndex: presentedSection)
        }
    }
}
