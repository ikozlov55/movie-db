//
//  LoginAnimator.swift
//  MovieDB
//
//  Created by Илья Козлов on 05.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class LoginAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to)
            else {
                transitionContext.completeTransition(true)
                return
        }
        transitionContext.containerView.addSubview(toView)
        toView.alpha = 0
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: [],
            animations: {
                toView.alpha = 1
            },
            completion: { result in
                transitionContext.completeTransition(result)
            }
        )
    }
    
}
