//
//  TermsAndCondotionsViewController.swift
//  SharingSpendings
//
//  Created by User on 22.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class TermsAndCondotionsViewController: UIViewController, TermsAndConditionsViewControllerProtocol {
    var presenter: TermsAndConditionsPresenterProtocol?
    var backButton: UIButton?
    var titleLabel: UILabel?
    var textView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.viewWillAppear()
    }
    
    func setup(){
        titleLabel = UILabel()
        EsteticsModel.setLabel(style: .title, label: titleLabel!)
        titleLabel?.textAlignment = .center
        view.addSubview(titleLabel!)
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titleLabel?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel?.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        titleLabel?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        backButton = UIButton()
        view.addSubview(backButton!)
        backButton?.setImage(UIImage(named: "back_icon"), for: .normal)
        backButton?.translatesAutoresizingMaskIntoConstraints = false
        backButton?.centerYAnchor.constraint(equalTo: (titleLabel?.centerYAnchor)!).isActive = true
        backButton?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        backButton?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        backButton?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        backButton?.addTarget(self, action: #selector(backButtonClick(_:)), for: .touchUpInside)
        let edgeInsets = UIEdgeInsets(top: 4, left: 9, bottom: 4, right: 9)
        backButton?.imageEdgeInsets = edgeInsets
        
        textView = UITextView()
        textView?.backgroundColor = .clear
        textView?.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
        textView?.textColor = EsteticsModel.inCellTextColor
        view.addSubview(textView!)
        textView?.translatesAutoresizingMaskIntoConstraints = false
        textView?.topAnchor.constraint(equalTo: (titleLabel?.bottomAnchor)!, constant: 10).isActive = true
        textView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        textView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        textView?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
    }
    
    func toggleToUserTermsMode() {
        titleLabel?.text = "User Terms"
        if let rtfPath = Bundle.main.url(forResource: "PrivacyPolicy", withExtension: "rtf") {
            do {
                let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: rtfPath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                self.textView!.attributedText = attributedStringWithRtf
            } catch let error {
                print("Got an error \(error)")
            }
        }
        textView?.textColor = EsteticsModel.inCellTextColor
    }
    
    func toggleToPrivacyPolicyMode() {
        titleLabel?.text = "Privacy Policy"
        if let rtfPath = Bundle.main.url(forResource: "PrivacyPolicy", withExtension: "rtf") {
            do {
                let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: rtfPath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                self.textView!.attributedText = attributedStringWithRtf
            } catch let error {
                print("Got an error \(error)")
            }
        }
        textView?.textColor = EsteticsModel.inCellTextColor
    }
    
    @objc func backButtonClick(_ sender: UIButton){
        presenter?.backButtonClicked()
    }
}
