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
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigation methods
    
    func start() {
        let controller = MovieSearchCoordinatingController()
        let tabBarItem = UITabBarItem(
            title: L10n.filmsTabTitle,
            image: Asset.tabBarMovies.image,
            tag: 0
        )
        controller.tabBarItem = tabBarItem
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: false)
    }
    
    func showDetailView(for movie: MovieViewModel) {
        let controller = FilmDetailCoordinatingController(movie)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}
