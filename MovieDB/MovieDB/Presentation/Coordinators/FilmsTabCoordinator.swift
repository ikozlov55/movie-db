//
//  FilmsTabCoordinator.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class FilmsTabCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: BaseNavigationController
    
    // MARK: - Init
    
    init(_ nc: BaseNavigationController) {
        self.navigationController = nc
    }
    
    // MARK: - Navigation methods
    
    func start() {
        let vc = FilmSearchCordinatingController()
        //vc.coordinator = self
        let tabBarItem = UITabBarItem(
            title: L10n.filmsTabTitle,
            image: Asset.tabBarMovies.image,
            tag: 0
        )
        vc.tabBarItem = tabBarItem
        navigationController.pushViewController(vc, animated: false)
    }

}
