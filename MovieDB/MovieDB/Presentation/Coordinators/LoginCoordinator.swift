//
//  LoginCoordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var nc: MDBNavigationController
    
    // MARK: - Init
    
    init(_ nc: MDBNavigationController) {
        self.nc = nc
        self.nc.isNavigationBarHidden = true
    }
    
    // MARK: - Navigation methods
    
    func start() {
        let vc = LoginViewController()
        vc.coordinator = self
        nc.pushViewController(vc, animated: true)
    }
    
    func login() {
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        nc.present(tabBar, animated: true)
        //nc.viewControllers.first?.present(tabBar, animated: true)
    }
}
