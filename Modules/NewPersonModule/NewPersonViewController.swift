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
        
        nameLabel.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
        nameTextField.font = UIFont.systemFont(ofSize: TableViewModel.inCellFontSize)
        nameTextField.attributedPlaceholder = NSAttributedString(string: nameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: EsteticsModel.placeholderTextColor])
        
        presenter?.viewWillAppear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchButtons() {
        addButton.isHidden = true
        confirmButton.isHidden = false
    }
    
    func getTextFieldData() -> String {
        return nameTextField.text!
    }
    
    func setLabeLMessage(message: String) {
        messageLabel.text = message
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func showPersonDetails(person: Person) {
        //  ItemsTable.isHidden = false
        nameTextField.text = person.name
    }
    
    func showAdditionErrorPopUp(with message: String){
        let popUp = ErrorPopUpViewController()
        popUp.message = message
        popUp.modalPresentationStyle = .overCurrentContext
        
        self.present(popUp, animated: true) {}
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        if nameTextField.text == ""{
            presenter?.invalidInput()
        }
        else{
            presenter?.confirmButtonClicked()
        }
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        if nameTextField.text == ""{
            presenter?.invalidInput()
        }
        else{
            presenter?.addButtonClicked()
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
