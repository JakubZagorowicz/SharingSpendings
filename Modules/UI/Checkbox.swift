//
//  Checkbox.swift
//  SharingSpendings
//
//  Created by User on 30.11.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import UIKit

class CheckBox : UIControl{
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc private func handleTap(recognizer: UITapGestureRecognizer) {
        isChecked = !isChecked
        sendActions(for: .touchDown)
    }
    
    func setImage(image: UIImage){
        self.imageView?.image = image
    }
    
    func setup(){
        imageView = UIImageView()
        addSubview(imageView!)
   //     self.setImage(image: UIImage(named: "checkbox_off")!)
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView?.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView?.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        addGestureRecognizer(tapGesture)
    }
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(image: UIImage(named: "checkbox_on")!)
            }
            else {
                self.setImage(image: UIImage(named: "checkbox_off")!)
            }
        }
    }
}
