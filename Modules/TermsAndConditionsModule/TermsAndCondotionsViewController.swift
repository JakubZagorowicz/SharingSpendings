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
    var mainLabel: UILabel?
    
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
        
        mainLabel = UILabel()
        mainLabel?.numberOfLines = 0
        view.addSubview(mainLabel!)
        mainLabel?.translatesAutoresizingMaskIntoConstraints = false
        mainLabel?.topAnchor.constraint(equalTo: (titleLabel?.bottomAnchor)!, constant: 30).isActive = true
        mainLabel?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        mainLabel?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        mainLabel?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
    }
    
    func toggleToUserTermsMode() {
        titleLabel?.text = "User Terms"
        mainLabel?.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum pharetra scelerisque. Nam elementum dictum eros, eget vulputate massa finibus ut. Vestibulum scelerisque tortor libero, nec sollicitudin libero lacinia rutrum. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque nec neque consectetur, aliquam risus ut, luctus quam. Nulla neque dolor, faucibus non euismod et, consectetur aliquam massa. Aliquam tempus tempus odio, a molestie est congue sed. Vivamus facilisis orci id ipsum facilisis scelerisque. Pellentesque pulvinar magna non felis dictum finibus. Phasellus rutrum elit accumsan odio sagittis vestibulum. Praesent laoreet feugiat risus, scelerisque iaculis libero sagittis ac. Mauris maximus non erat sed laoreet. Suspendisse et fringilla diam. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nullam ac turpis in nunc ornare vehicula. Fusce vestibulum tincidunt felis eu gravida. Pellentesque dapibus non ante quis porta. Pellentesque sit amet dui id lorem ullamcorper iaculis non nec arcu. Nulla rhoncus sapien nec dolor hendrerit lobortis. Mauris vitae sapien aliquet, volutpat lectus at, pulvinar arcu. Morbi pulvinar pellentesque nulla vel iaculis. Curabitur vehicula orci nulla, ut iaculis elit tristique et. Mauris mollis urna vel felis vestibulum sollicitudin. Maecenas commodo diam tellus, vitae porttitor mi finibus nec. Aliquam elementum ipsum vel dui porta, sed malesuada quam vulputate. Integer cursus suscipit sollicitudin. Fusce hendrerit ut nisl in eleifend. Proin tortor nunc, eleifend sit amet diam ac, blandit elementum ipsum. Nullam accumsan porttitor tellus sit amet maximus. Duis ac tristique est, nec vehicula odio. Nunc auctor lacus quis risus porta mollis. Donec maximus molestie felis, ac pharetra sapien scelerisque suscipit. Mauris ac dui euismod, pharetra nisi sed, tempus urna. Duis consequat quis orci ut dapibus. Etiam laoreet eros at faucibus maximus. Suspendisse euismod sapien et ligula condimentum euismod. Mauris pulvinar, orci id ultrices euismod, massa turpis tempor ante, eu consequat lacus nulla id nunc."
    }
    
    func toggleToPrivacyPolicyMode() {
        titleLabel?.text = "Privacy Policy"
        mainLabel?.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis bibendum pharetra scelerisque. Nam elementum dictum eros, eget vulputate massa finibus ut. Vestibulum scelerisque tortor libero, nec sollicitudin libero lacinia rutrum. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque nec neque consectetur, aliquam risus ut, luctus quam. Nulla neque dolor, faucibus non euismod et, consectetur aliquam massa. Aliquam tempus tempus odio, a molestie est congue sed. Vivamus facilisis orci id ipsum facilisis scelerisque. Pellentesque pulvinar magna non felis dictum finibus. Phasellus rutrum elit accumsan odio sagittis vestibulum. Praesent laoreet feugiat risus, scelerisque iaculis libero sagittis ac. Mauris maximus non erat sed laoreet. Suspendisse et fringilla diam. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nullam ac turpis in nunc ornare vehicula. Fusce vestibulum tincidunt felis eu gravida. Pellentesque dapibus non ante quis porta. Pellentesque sit amet dui id lorem ullamcorper iaculis non nec arcu. Nulla rhoncus sapien nec dolor hendrerit lobortis. Mauris vitae sapien aliquet, volutpat lectus at, pulvinar arcu. Morbi pulvinar pellentesque nulla vel iaculis. Curabitur vehicula orci nulla, ut iaculis elit tristique et. Mauris mollis urna vel felis vestibulum sollicitudin. Maecenas commodo diam tellus, vitae porttitor mi finibus nec. Aliquam elementum ipsum vel dui porta, sed malesuada quam vulputate. Integer cursus suscipit sollicitudin. Fusce hendrerit ut nisl in eleifend. Proin tortor nunc, eleifend sit amet diam ac, blandit elementum ipsum. Nullam accumsan porttitor tellus sit amet maximus. Duis ac tristique est, nec vehicula odio. Nunc auctor lacus quis risus porta mollis. Donec maximus molestie felis, ac pharetra sapien scelerisque suscipit. Mauris ac dui euismod, pharetra nisi sed, tempus urna. Duis consequat quis orci ut dapibus. Etiam laoreet eros at faucibus maximus. Suspendisse euismod sapien et ligula condimentum euismod. Mauris pulvinar, orci id ultrices euismod, massa turpis tempor ante, eu consequat lacus nulla id nunc."
    }
    
    @objc func backButtonClick(_ sender: UIButton){
        presenter?.backButtonClicked()
    }
}
