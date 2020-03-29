//
//  FilmSearchCordinatingController.swift
//  MovieDB
//
//  Created by Илья Козлов on 28.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class FilmSearchCordinatingController: BaseViewController {

    // MARK: - Private Properties
    
    private let welcomeController = FilmSearchWelcomeViewController()
    private let filmSearchController = FilmSearchViewController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWelcomeController()
        filmSearchController.delegate = self
        welcomeController.delegate = self
    }
    
    // MARK: - Private Methods
    
    private func showWelcomeController() {
        addChild(welcomeController)
        view.addSubview(welcomeController.view)
        welcomeController.view.frame = view.frame
        welcomeController.didMove(toParent: self)
    }
    
    private func showSearchViewController() {
        addChild(filmSearchController)
        view.addSubview(filmSearchController.view)
        
        let safeArea = view.safeAreaLayoutGuide
        let inset: CGFloat = 24
        filmSearchController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmSearchController.view.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: inset),
            filmSearchController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            filmSearchController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            filmSearchController.view.heightAnchor.constraint(equalToConstant: 48)
        ])
        filmSearchController.didMove(toParent: self)
    }

}

// MARK: - FilmSearchWelcomeViewControllerDelegate

extension FilmSearchCordinatingController: FilmSearchWelcomeViewControllerDelegate {
    func searchDidStarted() {
        welcomeController.willMove(toParent: nil)
        welcomeController.view.removeFromSuperview()
        welcomeController.removeFromParent()
        showSearchViewController()
    }
}

// MARK: - FilmSearchViewControllerDelegate

extension FilmSearchCordinatingController: FilmSearchViewControllerDelegate {
    func resultsLayoutChanged(to layout: SearchResultsLayout) {
        print(layout)
    }
}
