//
//  NewPersonModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 27.08.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class NewPersonViewController: UIViewController, NewPersonViewControllerProtocol {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var itemsTable: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    var presenter: NewPersonPresenterProtocol?
 
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        self.hideKeyboardOnTapOutside()
        
        titleLabel.font = EsteticsModel.titleLabelFont
        titleLabel.textColor = EsteticsModel.titleLabelTextColor
        
        nameLabel.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
        nameTextField.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
        nameTextField.attributedPlaceholder = NSAttributedString(string: nameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: EsteticsModel.placeholderTextColor])
        
        presenter?.viewWillAppear()
    }
    
    func switchButtons() {
        addButton.isHidden = true
        confirmButton.isHidden = false
    }
    
    func getTextFieldData() -> String {
        return nameTextField.text!
    }

    func showPersonDetails(person: Person) {
        nameTextField.text = person.name
    }
    
    func toggleToEditMode() {
        titleLabel.text = "Edit person"
        addButton.isHidden = true
        confirmButton.isHidden = false
    }
    
    func toggleToClosedMode() {
        titleLabel.text = "Person details"
        addButton.isHidden = true
        nameTextField.isEnabled = false
    }
    
    func showAdditionErrorPopUp(with message: String){
        let popUp = ErrorPopUpViewController()
        popUp.message = message
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.modalTransitionStyle = .crossDissolve
        
        self.present(popUp, animated: true) {}
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        if nameTextField.text == ""{
            presenter?.invalidInput()
        }
        else{
            presenter?.confirmButtonClicked(nameData: nameTextField.text!)
        }
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        if nameTextField.text == ""{
            presenter?.invalidInput()
        }
        else{
            presenter?.addButtonClicked(nameData: nameTextField.text!)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        presenter?.backButtonClicked()
    }
}

extension NewPersonViewController : UITextFieldDelegate{
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
