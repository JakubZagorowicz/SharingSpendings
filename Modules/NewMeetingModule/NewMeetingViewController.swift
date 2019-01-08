//
//  NewMeetingModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class NewMeetingViewController: UIViewController, NewMeetingViewControllerProtocol, UITextFieldDelegate {

    var presenter: NewMeetingPresenterProtocol?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        self.hideKeyboardOnTapOutside()
        titleLabel.font = EsteticsModel.titleLabelFont
        titleLabel.textColor = EsteticsModel.titleLabelTextColor
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: nameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: EsteticsModel.placeholderTextColor])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTextFieldData() -> String {
        return nameTextField.text!
    }
    
    func setMessageLabel(message: String) {
        messageLabel.text = message
    }
    
    func showPopUp(_with message: String){
        let popUp = ErrorPopUpViewController()
        popUp.message = message
        popUp.modalPresentationStyle = .overCurrentContext
        
        self.present(popUp, animated: true) {
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension NewMeetingViewController{ // Button clicks handling methods
    @IBAction func backButtonClicked(_ sender: Any) {
        presenter?.backButtonClicked()
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        if((nameTextField.text) != ""){
            presenter?.addButtonClicked()
        }
        else{
            presenter?.invalidNameProvided()
        }
    }
}


extension UIViewController {
    func hideKeyboardOnTapOutside(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyborad))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyborad(){
        view.endEditing(true)
    }
}
