//
//  CustomNavigatorController.swift
//  SharingSpendings
//
//  Created by User on 29.11.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class CustomNavigatorController: UINavigationController {
    override func viewDidLoad() {
        let backgroundView = UIImageView(image: UIImage(named: "bg2"))
        backgroundView.frame = UIScreen.main.bounds
        
        self.view.addSubview(backgroundView)
        self.view.sendSubviewToBack(backgroundView)
        self.delegate = self as UINavigationControllerDelegate
    }

}

extension CustomNavigatorController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return Animator.init(operationType: operation) as UIViewControllerAnimatedTransitioning
    }

    
}
