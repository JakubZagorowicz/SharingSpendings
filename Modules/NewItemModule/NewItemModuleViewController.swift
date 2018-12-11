//
//  NewItemModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class NewItemModuleViewController: UIViewController, NewItemModuleViewControllerProtocol, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var paidByButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var PriceTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var UsedByTableView: UITableView!
    var presenter: NewItemModulePresenterProtocol?
    var people: [Person]?
    var item: Item?
    var usedBy = [Person]()
    var pickedPerson : Person?

    override func viewDidLoad() {
        super.viewDidLoad()

        UsedByTableView.delegate = self
        UsedByTableView.dataSource = self

        PriceTextField.delegate = self
        NameTextField.delegate = self
        
        self.hideKeyboardOnTapOutside()
        
        presenter?.ViewWillAppear()
        SetUpView()
        
        if(item != nil){
            usedBy = Array((item?.usedBy)!) as! [Person]
        }
        else{
            usedBy = people!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SwitchButtons() {
        confirmButton.isHidden = false
        addButton.isHidden = true
    }
    
    func SetPeopleData(people: [Person]) {
        self.people = people
    }
    
    func FillWithItemData(item: Item){
        self.item = item
        NameTextField.text = item.name
        PriceTextField.text = String(format: "%0.02f", item.cost)
        paidByButton.setTitle(item.buyer?.name, for: .normal)
        paidByButton.titleLabel?.textAlignment = .left
        pickedPerson = item.buyer
//        for person in people!{
//            if item.buyer === person{
//                PaidByPicker.selectRow((people?.index(of: person))!, inComponent: 0, animated: false)
//            }
//        }
    }
    
    func UpdateMessage(message: String){
        MessageLabel.text = message
    }
    
    func IsInputDataOk() -> Bool{
        var status = true
        if(NameTextField.text == ""){
            status = false
            presenter?.InvalidInput(error: ItemAdditionError.NoNameEntered)
        }
        else{
            if(PriceTextField.text == "" || Double(PriceTextField.text!) == nil){
                status = false
                presenter?.InvalidInput(error: ItemAdditionError.InvalidPriceFormat)
            }
            else{
                if(Double(PriceTextField.text!)! <= 0.0){
                    status = false
                    presenter?.InvalidInput(error: ItemAdditionError.NegativePrice)
                }
                else{
                    if(usedBy.isEmpty){
                        status = false
                        presenter?.InvalidInput(error: ItemAdditionError.NoPersonUsingItem)
                    }
                }
            }
        }
        return status
    }
    
    func SetMessageLabel(message: String){
        MessageLabel.text = message
    }
    
    func GetItemData() -> ItemData {
        let name = NameTextField.text
        let price = Double(PriceTextField.text!)
  //      let buyer = people![PaidByPicker.selectedRow(inComponent: 0)]
        let buyer = pickedPerson!
        let itemData = ItemData(name: name!, cost: price!, buyer: buyer, usedBy: usedBy)
        
        return itemData
    }
    
    //--------------------------------Text field section---------------------------------
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        var allowedCharacters = CharacterSet.alphanumerics
        
        if textField == PriceTextField{
            allowedCharacters = CharacterSet.decimalDigits
        }
        return newString.length <= maxLength && allowedCharacters.isSuperset(of: CharacterSet(charactersIn: newString as String))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    
    
    //---------------------------------Table view section--------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (people?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UsedByCell
        cell.textLabel?.text = people![indexPath.row].name
        cell.textLabel?.textColor = EsteticsModel.inCellTextColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
        cell.selectionStyle = .none
    //    cell.usedBySwitch.isOn = usedBy.contains(people![indexPath.row])
        cell.usedByCheckbox.isChecked = usedBy.contains(people![indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UsedByCell
        cell.usedByCheckbox.isChecked = !cell.usedByCheckbox.isChecked
        if cell.usedByCheckbox.isChecked{
            usedBy.append(people![indexPath.row])
        }
        else{
            let upperBound = usedBy.count-1
            for i in stride(from: upperBound, to: -1, by: -1){
                if usedBy[i] == people![indexPath.row]{
                    usedBy.remove(at: i)
                }
            }
        }
        
    }
    //---------------------------------Picker view section--------------------------------
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return people!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return people![row].name
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let text = people![row].name
//        let attributes = NSAttributedString(string: text!, attributes: [NSAttributedStringKey.foregroundColor: EsteticsModel.pickerViewTextColor])
//        return attributes
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let text = people![row].name
        pickerLabel.attributedText = NSAttributedString(string: text!, attributes: [NSAttributedString.Key.foregroundColor: EsteticsModel.pickerViewTextColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)])
        return pickerLabel
    }
    
    //----------------------------------Checkbox section--------------------------------
    
    @IBAction func CheckboxValueChanged(_ sender: Any) {
        let sender = sender as! Checkbox
        let cell = sender.superview?.superview as! UITableViewCell
        let index = UsedByTableView.indexPath(for: cell)?.row
        if !sender.isChecked{
            usedBy.append(people![index!])
        }
        else{
            let upperBound = usedBy.count-1
            for i in stride(from: upperBound, to: -1, by: -1){
                if usedBy[i] == people![index!]{
                    usedBy.remove(at: i)
                }
            }
        }
    }
//    @IBAction func SwtichValueChanged(_ sender: Any) {
//        let sender = sender as! UISwitch
//        let cell = sender.superview?.superview as! UITableViewCell
//        let index = UsedByTableView.indexPath(for: cell)?.row
//        if sender.isOn{
//            usedBy.append(people![index!])
//        }
//        else{
//            let upperBound = usedBy.count-1
//            for i in stride(from: upperBound, to: -1, by: -1){
//                if usedBy[i] == people![index!]{
//                    usedBy.remove(at: i)
//                }
//            }
//        }
//    }
    

    func SetUpView(){
        NameTextField.textColor = EsteticsModel.textFieldTextColor
        NameTextField.alpha = CGFloat(EsteticsModel.textFieldTransparency)
        MessageLabel.textColor = EsteticsModel.messageLabelTextColor
        
    }
}

extension NewItemModuleViewController{// Button clicks handling methods
    
    @IBAction func PaidBySpaceTapped(_ sender: Any) {
        let popOverVC = PaidByPopUpViewController()
        popOverVC.tableViewData = people
        popOverVC.delegate = self
        popOverVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(popOverVC, animated: true) {
        }
        
    }
    @IBAction func AddButtonClicked(_ sender: Any) {
        if(IsInputDataOk()){
            presenter?.AddButtonClicked()
        }
    }
    
    @IBAction func ConfirmButtonClicked(_ sender: Any) {
        if(IsInputDataOk()){
            presenter?.ConfirmButtonClicked()
        }
    }
    
    @IBAction func BackButtonClicked(_ sender: Any) {
        presenter?.BackButtonClicked()
    }
}
