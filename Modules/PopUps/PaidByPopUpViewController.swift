//
//  UsedByPopUpViewController.swift
//  SharingSpendings
//
//  Created by User on 05.12.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class PaidByPopUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewData: [Person]?
    var tableView = UITableView(frame: .zero)
    var cancelButton: UIButton?
    var backgroundButton: UIButton?
    var delegate : NewItemViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupView()
        
    }
    
    func setupView(){
        self.view.frame = super.view.frame
        
        backgroundButton = UIButton(frame: view.frame)
        backgroundButton?.backgroundColor = .black
        backgroundButton?.alpha = 0.7
        backgroundButton?.addTarget(self, action: #selector(backgroundButtonTapped), for: .touchDown)

        tableView.delegate = self
        tableView.dataSource = self
        
        cancelButton = UIButton(frame: .zero)

        view.addSubview(backgroundButton!)
        view.addSubview(tableView)
        view.addSubview(cancelButton!)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton?.translatesAutoresizingMaskIntoConstraints = false

        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        cancelButton?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton?.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        
        cancelButton?.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        cancelButton?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cancelButton?.backgroundColor = UIColor.gray
        cancelButton?.setTitle("Cancel", for: .normal)
        cancelButton?.setTitleColor(EsteticsModel.inCellTextColor, for: .normal)
        cancelButton?.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        cancelButton?.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        view.bringSubviewToFront(cancelButton!)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableViewData?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tableViewData![indexPath.row].name
        cell.textLabel?.textColor = UIColor.darkGray
        cell.textLabel?.font = UIFont.systemFont(ofSize: EsteticsModel.inCellFontSize)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EsteticsModel.cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.pickedPerson = tableViewData?[indexPath.row]
        delegate?.paidByButton.setTitle(delegate?.pickedPerson?.name, for: .normal)
        backgroundButton?.isHidden = true
        self.dismiss(animated: true, completion: self.view.removeFromSuperview)
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                self.dismiss(animated: true, completion: nil)
            }
        });
    }

    @objc func backgroundButtonTapped(sender: UIButton){
        sender.isHidden = true
        self.dismiss(animated: true, completion: self.view.removeFromSuperview)
    //    self.view.removeFromSuperview()
        //removeAnimate()
       // self.dismiss(animated: false, completion: nil)
    }
    
    @objc func cancelButtonClicked(sender: UIButton){
        backgroundButton?.isHidden = true
        self.dismiss(animated: true, completion: self.view.removeFromSuperview)

//        removeAnimate()
    }
}
