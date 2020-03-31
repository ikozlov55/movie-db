//
//  UIViewController+Extension.swift
//  MovieDB
//
//  Created by Илья Козлов on 31.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
