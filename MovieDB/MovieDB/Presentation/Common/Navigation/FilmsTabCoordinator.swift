//
//  FilmsTabCoordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class FilmsTabCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var nc: BaseNavigationController
    
    // MARK: - Init
    
    init(_ nc: BaseNavigationController) {
        self.nc = nc
    }
    
    // MARK: - Navigation methods
    
    func start() {
        let vc = FilmSearchViewController()
        vc.coordinator = self
        let tabBarItem = UITabBarItem(
            title: L10n.filmsTabTitle,
            image: Asset.tabBarMovies.image,
            tag: 0
        )
        vc.tabBarItem = tabBarItem
        nc.pushViewController(vc, animated: false)
    }

}
