//
//  FavoriteTabCoordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class FavoriteTabCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var nc: MDBNavigationController
    
    // MARK: - Init
    
    init(_ nc: MDBNavigationController) {
        self.nc = nc
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
        nc.pushViewController(vc, animated: false)
    }

}
