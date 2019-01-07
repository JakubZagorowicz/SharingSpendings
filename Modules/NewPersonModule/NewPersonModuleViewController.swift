//
//  NewPersonModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class NewPersonModuleViewController: UIViewController, NewPersonModuleViewControllerProtocol, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var ItemsTable: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    var presenter: NewPersonModulePresenterProtocol?
 
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        self.hideKeyboardOnTapOutside()
        
        titleLabel.font = EsteticsModel.titleLabelFont
        titleLabel.textColor = EsteticsModel.titleLabelTextColor
        
        nameLabel.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
        nameTextField.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
        nameTextField.attributedPlaceholder = NSAttributedString(string: nameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: EsteticsModel.placeholderTextColor])
        
        presenter?.ViewWillAppear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SwitchButtons() {
        AddButton.isHidden = true
        ConfirmButton.isHidden = false
    }
    
    func GetTextFieldData() -> String {
        return nameTextField.text!
    }
    
    func SetLabeLMessage(message: String) {
        messageLabel.text = message
    }
    
    func SetTitle(title: String) {
        titleLabel.text = title
    }
    
    func ShowPersonDetails(person: Person) {
        //  ItemsTable.isHidden = false
        nameTextField.text = person.name
    }
    
    func ShowPopUp(_with message: String){
        let popUp = ErrorPopUpViewController()
        popUp.message = message
        popUp.modalPresentationStyle = .overCurrentContext
        
        self.present(popUp, animated: true) {
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 14
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
}

extension NewPersonModuleViewController{ // Button click methods section
    @IBAction func ConformButtonClicked(_ sender: Any) {
        if nameTextField.text == ""{
            presenter?.InvalidInput()
        }
        else{
            presenter?.ConfirmButtonClicked()
        }
    }
    
    @IBAction func AddButtonClicked(_ sender: Any) {
        if nameTextField.text == ""{
            presenter?.InvalidInput()
        }
        else{
            presenter?.AddButtonClicked()
        }
    }
    @IBAction func BackButtonClicked(_ sender: Any) {
        presenter?.BackButtonClicked()
    }
}
