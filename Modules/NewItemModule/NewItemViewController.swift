//
//  NewItemModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController, NewItemViewControllerProtocol {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var paidByLabel: UILabel!
    @IBOutlet weak var usedByLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var paidByButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usedByTableView: UITableView!
    var presenter: NewItemPresenterProtocol?
    var eventMembers: [Person]?
    var editingItem: Item?
    var usersList = [Person]()
    var pickedPerson : Person?
    var checkBoxEnabled: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewWillAppear()
        setupView()
        
        if(editingItem != nil){
            usersList = Array((editingItem?.usedBy)!) as! [Person]
        }
        else{
            usersList = eventMembers!
        }
    }
    
    func switchButtons() {
        confirmButton.isHidden = false
        addButton.isHidden = true
    }
    
    func setPeopleData(people: [Person]) {
        self.eventMembers = people
    }
    
    func fillWithItemData(item: Item){
        self.editingItem = item
        nameTextField.text = item.name
        priceTextField.text = String(format: "%0.02f", item.cost)
        paidByButton.setTitle(item.buyer?.name, for: .normal)
        paidByButton.titleLabel?.textAlignment = .left
        pickedPerson = item.buyer
    }
    
    func isInputDataOk() -> Bool{
        var status = true
        if(nameTextField.text == ""){
            status = false
            presenter?.invalidInput(error: itemAdditionError.noNameEntered)
        }
        else{
            if(priceTextField.text == "" || Double(priceTextField.text!) == nil){
                status = false
                presenter?.invalidInput(error: itemAdditionError.noPriceEntered)
            }
            else{
                if(Double(priceTextField.text!)! <= 0.0){
                    status = false
                    presenter?.invalidInput(error: itemAdditionError.negativePrice)
                }
                else{
                    if(pickedPerson == nil)
                    {
                        presenter?.invalidInput(error: itemAdditionError.noBuyerPicked)
                        status = false
                    }
                    if(usersList.isEmpty){
                        status = false
                        presenter?.invalidInput(error: itemAdditionError.noPersonUsingItem)
                    }
                }
            }
        }
        return status
    }
    
    func toggleToEditMode(){
        titleLabel.text = "Edit item"
        confirmButton.isHidden = false
        addButton.isHidden = true
    }
    
    func toggleToClosedMode(){
        titleLabel.text = "Item details"
        addButton.isHidden = true
        nameTextField.isEnabled = false
        priceTextField.isEnabled = false
        paidByButton.isEnabled = false
        checkBoxEnabled = false
        usedByTableView.allowsSelection = false
    }
    
    func showAdditionErrorPopUp(with message: String){
        let popUp = ErrorPopUpViewController()
        popUp.message = message
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.modalTransitionStyle = .crossDissolve

        self.present(popUp, animated: true) {}
    }
    
    func getItemData() -> ItemData {
        let name = nameTextField.text
        let price = Double(priceTextField.text!)
        let buyer = pickedPerson!
        let itemData = ItemData(name: name!, cost: price!, buyer: buyer, usedBy: usersList)
        
        return itemData
    }
    
    @objc func checkboxValueChanged(_ sender: Any) {
        let sender = sender as! CheckBox
        let cell = sender.superview as! UITableViewCell
        let index = usedByTableView.indexPath(for: cell)?.row
        if sender.isChecked{
            usersList.append(eventMembers![index!])
        }
        else{
            let upperBound = usersList.count-1
            for i in stride(from: upperBound, to: -1, by: -1){
                if usersList[i] == eventMembers![index!]{
                    usersList.remove(at: i)
                }
            }
        }
    }

    func setupView(){
        usedByTableView.delegate = self
        usedByTableView.dataSource = self
        
        priceTextField.delegate = self
        nameTextField.delegate = self
        
        self.hideKeyboardOnTapOutside()
        
        titleLabel.font = EsteticsModel.titleLabelFont
        titleLabel.textColor = EsteticsModel.titleLabelTextColor
        nameLabel.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
        priceLabel.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
        paidByLabel.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
        usedByLabel.font = UIFont.systemFont(ofSize: EsteticsModel.headerLabelFontSize)
        
        nameTextField.textColor = EsteticsModel.textFieldTextColor
        nameTextField.alpha = CGFloat(EsteticsModel.textFieldTransparency)
        nameTextField.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
        nameTextField.attributedPlaceholder = NSAttributedString(string: nameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: EsteticsModel.placeholderTextColor])
        priceTextField.attributedPlaceholder = NSAttributedString(string: priceTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: EsteticsModel.placeholderTextColor])
        priceTextField.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
        paidByButton.titleLabel?.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
    }
    
    @IBAction func paidBySpaceTapped(_ sender: Any) {
        let popOverVC = PaidByPopUpViewController()
        popOverVC.tableViewData = eventMembers
        popOverVC.delegate = self
        popOverVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        popOverVC.modalTransitionStyle = .crossDissolve
        self.present(popOverVC, animated: true) {}
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        if(isInputDataOk()){
            presenter?.addButtonClicked()
        }
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        if(isInputDataOk()){
            presenter?.confirmButtonClicked()
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        presenter?.backButtonClicked()
    }
}

extension NewItemViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (eventMembers?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EsteticsModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! CheckboxCell
        cell.setupCell()
        cell.textLabel?.text = eventMembers![indexPath.row].name
        cell.textLabel?.textColor = EsteticsModel.inCellTextColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
        cell.selectionStyle = .none
        cell.checkBox.isChecked = usersList.contains(eventMembers![indexPath.row])
        cell.checkBox.addTarget(self, action: #selector(checkboxValueChanged(_:)), for: .touchDown)
        cell.checkBox.isEnabled = checkBoxEnabled
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CheckboxCell
        cell.checkBox.isChecked = !cell.checkBox.isChecked
        if cell.checkBox.isChecked{
            usersList.append(eventMembers![indexPath.row])
        }
        else{
            let upperBound = usersList.count-1
            for i in stride(from: upperBound, to: -1, by: -1){
                if usersList[i] == eventMembers![indexPath.row]{
                    usersList.remove(at: i)
                }
            }
        }
    }
}

extension NewItemViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        var allowedCharacters = CharacterSet.alphanumerics
        
        if textField == priceTextField{
            allowedCharacters = CharacterSet.decimalDigits
            allowedCharacters.insert(charactersIn: ".")
        }
        return newString.length <= maxLength && allowedCharacters.isSuperset(of: CharacterSet(charactersIn: newString as String))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
}
