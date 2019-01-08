//
//  Animator.swift
//  SharingSpendings
//
//  Created by User on 29.11.2018.
//  Copyright © 2018 Jakub Zagórowicz. All rights reserved.
//

import Foundation
import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    var operationType: UINavigationController.Operation
    
    public init(operationType: UINavigationController.Operation) {
        self.operationType = operationType
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let transition = CATransition.init()
        transition.duration = 0.2
        if(operationType == UINavigationController.Operation.push){
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
        }
        if(operationType == UINavigationController.Operation.pop){
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
        }
        transitionContext.containerView.layer.removeAnimation(forKey: kCATransition)
        transitionContext.containerView.layer.add(transition, forKey: kCATransition)
        
        toView?.view.frame = transitionContext.containerView.frame
        
        UIView.animate(withDuration: transition.duration, animations: {
            fromView?.view.removeFromSuperview()
            transitionContext.containerView.addSubview((toView?.view)!)
            
        }) { finished in
                transitionContext.completeTransition(true)
        }
    }
}
