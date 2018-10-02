//
//  NewPersonModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class NewPersonModuleViewController: UIViewController, NewPersonModuleViewControllerProtocol, UITextFieldDelegate {

    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var ItemsTable: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    var presenter: NewPersonModulePresenterProtocol?
 
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
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
    
    func ShowPersonDetails(person: Person) {
        //  ItemsTable.isHidden = false
        nameTextField.text = person.name
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 14
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}

extension NewPersonModuleViewController{ // Button click methods section
    @IBAction func ConformButtonClicked(_ sender: Any) {
        presenter?.ConfirmButtonClicked()
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
