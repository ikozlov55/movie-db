//
//  MovieSearchCordinatingController.swift
//  MovieDB
//
//  Created by Илья Козлов on 28.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class MovieSearchCordinatingController: BaseViewController {
    
    // MARK: - Private Properties
    
    private let welcomeController = MovieSearchStartViewController()
    private var filmSearchController: MovieSearchViewControllerProtocol!
    private let emptySearchResultsController = EmptySearchResultsViewController()
    private let moviesListController = MoviesListViewController()
    private let loader = LoadingViewController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWelcomeController()
        filmSearchController = MovieSearchViewController()
        filmSearchController.delegate = self
        welcomeController.delegate = self
    }
    
    // MARK: - Private Methods
    
    private func showWelcomeController() {
        add(child: welcomeController)
        welcomeController.view.frame = view.frame
    }
    
    private func showSearchViewController() {
        add(child: filmSearchController)
        let safeArea = view.safeAreaLayoutGuide
        let inset: CGFloat = 24
        filmSearchController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmSearchController.view.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: inset),
            filmSearchController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            filmSearchController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            filmSearchController.view.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func addChildToContentArea(_ viewController: UIViewController) {
        add(child: viewController)
        let safeArea = view.safeAreaLayoutGuide
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: filmSearchController.view.bottomAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}

// MARK: - MovieSearchStartViewControllerDelegate

extension MovieSearchCordinatingController: MovieSearchStartViewControllerDelegate {
    func searchDidStarted() {
        welcomeController.willMove(toParent: nil)
        welcomeController.view.removeFromSuperview()
        welcomeController.removeFromParent()
        showSearchViewController()
    }
}

// MARK: - FilmSearchViewControllerDelegate

extension MovieSearchCordinatingController: MovieSearchViewControllerDelegate {
    func searchStarted() {
        addChildToContentArea(loader)
    }
    
    func searchFinished(with result: MoviesList) {
        if result.totalResults == 0 {
            loader.remove()
            addChildToContentArea(emptySearchResultsController)
        } else {
            loader.remove()
            let data = result.results.map { MovieVMTranformer.movieVM(from: $0) }
            addChildToContentArea(moviesListController)
            moviesListController.show(data)
        }
    }
    
    func resultsLayoutChanged(to layout: SearchResultsLayout) {
        print(layout)
    }
}
