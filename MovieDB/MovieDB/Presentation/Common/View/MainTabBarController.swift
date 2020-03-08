//
//  MainTabBarController.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let filmsTabCoordinator = FilmsTabCoordinator(
        BaseNavigationController()
    )
    let favoriteTabCoordinator = FavoriteTabCoordinator(
        BaseNavigationController()
    )
    let profileTabCoordinator = ProfileTabCoordinator(
        BaseNavigationController()
    )
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarItems()
    }
    
    // MARK: - UI Setup
    
    private func setupTabBar() {
        tabBar.barTintColor = ColorName.tabBarBlue.color
        tabBar.tintColor = ColorName.red.color
        tabBar.unselectedItemTintColor = ColorName.lightBlue.color
        tabBar.itemWidth = 100
    }
    
    private func setupTabBarItems() {
        filmsTabCoordinator.start()
        favoriteTabCoordinator.start()
        profileTabCoordinator.start()
        
        viewControllers = [
            filmsTabCoordinator.nc,
            favoriteTabCoordinator.nc,
            profileTabCoordinator.nc
        ]
    }
    
}
