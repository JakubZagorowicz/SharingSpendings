//
//  SlideInMenu.swift
//  SharingSpendings
//
//  Created by User on 18.01.2019.
//  Copyright © 2019 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class SlideInMenu: UIView {
    private var optionsTableView: UITableView?
    private var logoImageView: UIImageView?
    private var copyrigthLabel: UILabel?
    private var options: [SlideMenuOptions] = [SlideMenuOptions.privacyPolicy, SlideMenuOptions.userTerms]
    private var backgroundImage: UIImageView?
    
    var delegate: SlideInMenuDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        backgroundImage = UIImageView()
        backgroundImage?.image = UIImage(named: "bg2")
        addSubview(backgroundImage!)
        backgroundImage?.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImage?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundImage?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundImage?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        logoImageView = UIImageView()
        logoImageView?.image = UIImage(named: "Logo")
        addSubview(logoImageView!)
        logoImageView?.translatesAutoresizingMaskIntoConstraints = false
        logoImageView?.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        logoImageView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoImageView?.widthAnchor.constraint(equalToConstant: 80).isActive = true
        logoImageView?.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        copyrigthLabel = UILabel()
        addSubview(copyrigthLabel!)
        copyrigthLabel?.text = "(c) Copyrigth 2019 DoraDigital"
        copyrigthLabel?.textColor = .white
        copyrigthLabel?.textAlignment = .center
        copyrigthLabel?.font = UIFont.systemFont(ofSize: 12)
        copyrigthLabel?.translatesAutoresizingMaskIntoConstraints = false
        copyrigthLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        copyrigthLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        copyrigthLabel?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        copyrigthLabel?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        optionsTableView = UITableView()
        optionsTableView?.backgroundColor = .clear
        optionsTableView?.delegate = self
        optionsTableView?.dataSource = self
        optionsTableView?.alwaysBounceVertical = false
        addSubview(optionsTableView!)
        optionsTableView?.translatesAutoresizingMaskIntoConstraints = false
        optionsTableView?.topAnchor.constraint(equalTo: (logoImageView?.bottomAnchor)!, constant: 30).isActive = true
        optionsTableView?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        optionsTableView?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        optionsTableView?.bottomAnchor.constraint(equalTo: (copyrigthLabel?.topAnchor)!, constant: -10).isActive = true
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

extension SlideInMenu: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.text = options[indexPath.row].getName()
        EsteticsModel.setLabel(style: .tableCell, label: cell.textLabel!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.slideInMenuDelegate(self, selectedRowWith: options[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
}
