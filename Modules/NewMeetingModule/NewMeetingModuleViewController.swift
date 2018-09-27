//
//  NewMeetingModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class NewMeetingModuleViewController: UIViewController, NewMeetingModuleViewControllerProtocol, UITextFieldDelegate {

    var presenter: NewMeetingModulePresenterProtocol?
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func BackButtonClicked(_ sender: Any) {
        presenter?.BackButtonClicked()
    }
    
    @IBAction func AddButtonClicked(_ sender: Any) {
        if((NameTextField.text) != ""){
            presenter?.AddButtonClicked()
        }
        else{
            presenter?.InvalidName()
        }
    }
    
    func GetTextFieldData() -> String {
        return NameTextField.text!
    }
    
    func SetMessageLabel(message: String) {
        messageLabel.text = message
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NameTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
