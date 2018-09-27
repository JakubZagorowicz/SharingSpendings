//
//  LoginModuleViewController.swift
//  SharingSpendings
//
//  Created by User on 11.07.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class LoginModuleViewController: UIViewController, LoginModuleViewControllerProtocol {

    @IBAction func OfflineModeButtonClicked(_ sender: Any) {
        presenter?.OfflineModeButtonClick()
    }
    var presenter: LoginModulePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
