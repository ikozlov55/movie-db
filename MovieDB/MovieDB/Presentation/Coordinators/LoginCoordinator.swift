//
//  LoginCoordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: BaseNavigationController
    
    // MARK: - Init
    
    init(_ nc: BaseNavigationController) {
        self.navigationController = nc
        self.navigationController.isNavigationBarHidden = true
    }
    
    // MARK: - Navigation methods
    
    func start() {
        let vc = LoginViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func login() {
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        navigationController.present(tabBar, animated: true)
    }
}
