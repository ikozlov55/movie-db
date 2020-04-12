//
//  FavoritesTabCoordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class FavoritesTabCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: BaseNavigationController
    
    // MARK: - Init
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigation methods
    
    func start() {
        let controller = FavoritesCoordinatingController()
        controller.coordinator = self
        let tabBarItem = UITabBarItem(
            title: L10n.favoriteTitle,
            image: Asset.tabBarFavorite.image,
            tag: 1
        )
        controller.tabBarItem = tabBarItem
        navigationController.pushViewController(controller, animated: false)
    }

}
