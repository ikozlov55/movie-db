//
//  ProfileTabCoordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class ProfileTabCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: BaseNavigationController
    
    // MARK: - Init
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigation methods
    
    func start() {
        let controller = ProfileViewController()
        controller.coordinator = self
        let tabBarItem = UITabBarItem(
            title: L10n.profileTabTitle,
            image: Asset.tabBarProfile.image,
            tag: 2
        )
        controller.tabBarItem = tabBarItem
        navigationController.pushViewController(controller, animated: false)
    }
    
    func logout() {
        let navigationController = BaseNavigationController()
        let coordinator = LoginCoordinator(navigationController)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        coordinator.start()
    }

}
