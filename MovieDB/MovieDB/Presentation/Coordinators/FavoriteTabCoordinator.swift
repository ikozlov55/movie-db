//
//  FavoriteTabCoordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class FavoriteTabCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: BaseNavigationController
    
    // MARK: - Init
    
    init(_ nc: BaseNavigationController) {
        self.navigationController = nc
    }
    
    // MARK: - Navigation methods
    
    func start() {
        let vc = FavoriteViewController()
        vc.coordinator = self
        let tabBarItem = UITabBarItem(
            title: L10n.favoriteTitle,
            image: Asset.tabBarFavorite.image,
            tag: 1
        )
        vc.tabBarItem = tabBarItem
        navigationController.pushViewController(vc, animated: false)
    }

}
