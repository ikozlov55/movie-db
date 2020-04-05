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
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    // MARK: - Navigation methods
    
    func start() {
        let controller = LoginViewController()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func login(_ transitioningDelegate: UIViewControllerTransitioningDelegate?) {
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .custom
        tabBar.transitioningDelegate = transitioningDelegate
        navigationController.viewControllers.remove(at: 0)
        navigationController.present(tabBar, animated: true)
    }
}
