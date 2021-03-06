//
//  ErrorPopUp.swift
//  SharingSpendings
//
//  Created by User on 12.12.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class ErrorPopUpViewController : UIViewController{
    var okButton = UIButton(frame: .zero)
    var backgroundButton : UIButton?
    var messageLabel = UILabel(frame: .zero)
    var message = ""
    var containerView = UIView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView(){
        okButton.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        view.frame = super.view.frame
        
        backgroundButton = UIButton()
        view.addSubview(backgroundButton!)
        backgroundButton?.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.7)
        backgroundButton?.addTarget(self, action: #selector(okButtonClicked), for: .touchDown)
        backgroundButton?.translatesAutoresizingMaskIntoConstraints = false
        backgroundButton?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundButton?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundButton?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundButton?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        view.addSubview(okButton)
        view.addSubview(messageLabel)
        
        messageLabel.text = message
        messageLabel.numberOfLines = 2
        messageLabel.textColor = EsteticsModel.messageLabelTextColor
        messageLabel.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
        messageLabel.textAlignment = .center
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messageLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.7).isActive = true
        messageLabel.adjustsFontSizeToFitWidth = true
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: messageLabel.frame.height + 80).isActive = true
        
        okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchDown)
        okButton.setTitle("OK", for: .normal)
        okButton.backgroundColor = EsteticsModel.editButtonBackgroundColor
        
        okButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        okButton.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        okButton.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.bringSubviewToFront(okButton)
        view.bringSubviewToFront(messageLabel)
    }
    
    @objc func okButtonClicked(sender: UIButton){
        self.dismiss(animated: true, completion: self.view.removeFromSuperview)
    }
}
