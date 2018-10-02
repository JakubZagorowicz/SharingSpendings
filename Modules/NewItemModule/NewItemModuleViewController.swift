//
//  NewItemModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class NewItemModuleViewController: UIViewController, NewItemModuleViewControllerProtocol, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var PriceTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PaidByPicker: UIPickerView!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var UsedByTableView: UITableView!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 14
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (people?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UsedByCell
        cell.textLabel?.text = people![indexPath.row].name

        cell.usedBySwitch.isOn = usedBy.contains(people![indexPath.row])
 
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return people!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return people![row].name
    }

    var presenter: NewItemModulePresenterProtocol?
    var people: [Person]?
    var item: Item?
    var usedBy = [Person]()
    
    @IBAction func AddButtonClicked(_ sender: Any) {
        if(IsInputDataOk()){
            presenter?.AddButtonClicked()
        }
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
    @IBAction func ConfirmButtonClicked(_ sender: Any) {
        if(IsInputDataOk()){
            presenter?.ConfirmButtonClicked()
        }
    }
    
    @IBAction func BackButtonClicked(_ sender: Any) {
        presenter?.BackButtonClicked()
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
        
        for person in people!{
            if item.buyer === person{
                PaidByPicker.selectRow((people?.index(of: person))!, inComponent: 0, animated: false)
            }
        }
    }
    
    func UpdateMessage(message: String){
        MessageLabel.text = message
    }
    
    @IBAction func SwtichValueChanged(_ sender: Any) {
        let sender = sender as! UISwitch
        let cell = sender.superview?.superview as! UITableViewCell
        let index = UsedByTableView.indexPath(for: cell)?.row
//        usedBy[people![index!]] = !usedBy[people![index!]]!
        if sender.isOn{
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
    
    func SetMessageLabel(message: String){
        MessageLabel.text = message
    }
    
    func GetItemData() -> ItemData {
        let name = NameTextField.text
        let price = Double(PriceTextField.text!)
        let buyer = people![PaidByPicker.selectedRow(inComponent: 0)]
        let itemData = ItemData(name: name!, cost: price!, buyer: buyer, usedBy: usedBy)
        
        return itemData
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        UsedByTableView.delegate = self
        UsedByTableView.dataSource = self
        
        PaidByPicker.delegate = self
        PaidByPicker.dataSource = self
        
        presenter?.ViewWillAppear()
        
        if(item != nil){
            usedBy = Array((item?.usedBy)!) as! [Person]
        }
        else{
            usedBy = people!
        }
//        for person in people!{
//            usedBy[person] = true
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
