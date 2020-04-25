//
//  LoginCoordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `Coordinator` флоу авторизации
final class LoginCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: BaseNavigationController
    
    // MARK: - Init
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    // MARK: - Navigation methods
    
    /// Старт флоу авторизации
    func start() {
        if ServiceLayer.pinAuthorizationService.credentialsFound {
            authorizeWithPin()
        } else {
            let controller = LoginViewController()
            controller.coordinator = self
            navigationController.pushViewController(controller, animated: true)
        }
    }
    
    /// Успешная авторизация, переход на основной TabBar приложения
    /// - Parameter transitioningDelegate: `UIViewControllerTransitioningDelegate` обеспечивающий анимацию перехода с экрана авторизации на основной TabBar
    func login(_ transitioningDelegate: UIViewControllerTransitioningDelegate?) {
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .custom
        tabBar.transitioningDelegate = transitioningDelegate
        navigationController.viewControllers.remove(at: 0)
        navigationController.present(tabBar, animated: true)
    }
    
    /// Переход на флоу создания пин-кода
    func makePin() {
        let controller = PinAuthorizationCoordinatingController(stage: .makePin)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    /// Переход на флоу быстрой авторизации по пин-коду
    func authorizeWithPin() {
        let controller = PinAuthorizationCoordinatingController(stage: .fastLogin)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
}
