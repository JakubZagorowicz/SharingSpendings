//
//  AcceptablePopUp.swift
//  SharingSpendings
//
//  Created by User on 16.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class AcceptablePopUp: UIViewController{
    private var backgroundButton: UIButton?
    private var confirmButton: UIButton?
    private var cancelButton: UIButton?
    private var containerView: UIView?
    private var messageLabel: UILabel?
    private var message: String?
    private var confirmButtonText: String = "Yes"
    private var cancelButtonText: String = "No"
    
    var delegate: AcceptablePopUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView(){
        backgroundButton = UIButton(frame: view.frame)
        view.addSubview(backgroundButton!)
        backgroundButton?.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.7)
        backgroundButton?.addTarget(self, action: #selector(backgroundButtonClicked(sender:)), for: .touchUpInside)
        
        messageLabel = UILabel()
        view.addSubview(messageLabel!)
        EsteticsModel.setLabel(style: .whiteBackgroundCell, label: messageLabel!)
        messageLabel?.textAlignment = .center
        messageLabel?.text = message
        messageLabel?.numberOfLines = 2
        messageLabel?.translatesAutoresizingMaskIntoConstraints = false
        messageLabel?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messageLabel?.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.7).isActive = true
        messageLabel?.adjustsFontSizeToFitWidth = true
        
        containerView = UIView()
        containerView?.backgroundColor = .white
        view.addSubview(containerView!)
        containerView?.translatesAutoresizingMaskIntoConstraints = false
        containerView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView?.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        containerView?.heightAnchor.constraint(equalToConstant: messageLabel!.frame.height + 80).isActive = true
        
        confirmButton = UIButton()
        view.addSubview(confirmButton!)
        confirmButton?.backgroundColor = .gray
        confirmButton?.translatesAutoresizingMaskIntoConstraints = false
        confirmButton?.topAnchor.constraint(equalTo: containerView!.bottomAnchor).isActive = true
        confirmButton?.leftAnchor.constraint(equalTo: containerView!.leftAnchor).isActive = true
        confirmButton?.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmButton?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton?.addTarget(self, action: #selector(confirmButtonClicked(sender:)), for: .touchUpInside)
        confirmButton?.setTitle(confirmButtonText, for: .normal)
        
        cancelButton = UIButton()
        cancelButton?.backgroundColor = .gray
        view.addSubview(cancelButton!)
        cancelButton?.translatesAutoresizingMaskIntoConstraints = false
        cancelButton?.topAnchor.constraint(equalTo: containerView!.bottomAnchor).isActive = true
        cancelButton?.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton?.rightAnchor.constraint(equalTo: containerView!.rightAnchor).isActive = true
        cancelButton?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton?.addTarget(self, action: #selector(cancelButtonClicked(sender:)), for: .touchUpInside)
        cancelButton?.setTitle(cancelButtonText, for: .normal)
        
        view.bringSubviewToFront(messageLabel!)
    }
    
    func setMessage(message: String){
        self.message = message
    }
    
    func setButtonsTitle(confirmTitle: String, cancelTitle: String){
        confirmButtonText = confirmTitle
        cancelButtonText = cancelTitle
    }
    
    @objc func backgroundButtonClicked(sender: UIButton){
        dismiss(animated: true)
        delegate?.acceptablePopUp(self, didResolveWith: false)
    }
    
    @objc func cancelButtonClicked(sender: UIButton){
        dismiss(animated: true)
        delegate?.acceptablePopUp(self, didResolveWith: false)
    }
    
    @objc func confirmButtonClicked(sender: UIButton){
        dismiss(animated: true)
        delegate?.acceptablePopUp(self, didResolveWith: true)
    }
}
