//
//  MovieSearchCoordinatingController.swift
//  MovieDB
//
//  Created by Илья Козлов on 28.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `ViewController` контейнер для флоу авторизации
final class MovieSearchCoordinatingController: BaseViewController {
    
    // MARK: - Private Properties
    
    private let welcomeController: MovieSearchWelcomeViewController
    private var filmSearchController: MovieSearchViewControllerProtocol
    private let emptySearchResultsController: EmptySearchResultsViewController
    private let moviesListController: MoviesListViewController
    private let loader: LoadingViewController
    
    // MARK: - Init
    init() {
        welcomeController = MovieSearchWelcomeViewController()
        filmSearchController = MovieSearchViewController()
        emptySearchResultsController = EmptySearchResultsViewController()
        moviesListController = MoviesListViewController()
        loader = LoadingViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWelcomeController()
        filmSearchController.delegate = self
        welcomeController.delegate = self
    }
    
    // MARK: - Private Methods
    
    private func showLoader() {
        addChildToContentArea(loader)
    }
    
    private func hideLoader() {
        loader.remove()
    }
    
    private func showEmptySearchStub() {
        addChildToContentArea(emptySearchResultsController)
    }
    
    private func showSearchResults(_ moviesList: MoviesList) {
        addChildToContentArea(moviesListController)
        let movieViewModels = moviesList.results.map { MovieViewModelTransformer.viewModel(from: $0)
        }
        moviesListController.show(movieViewModels)
    }
    
    private func showWelcomeController() {
        add(child: welcomeController)
        view.fill(with: welcomeController.view)
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

// MARK: - MovieSearchWelcomeViewControllerDelegate

extension MovieSearchCoordinatingController: MovieSearchWelcomeViewControllerDelegate {
    func searchBarTaped() {
        welcomeController.willMove(toParent: nil)
        welcomeController.view.removeFromSuperview()
        welcomeController.removeFromParent()
        showSearchViewController()
    }
}

// MARK: - FilmSearchViewControllerDelegate

extension MovieSearchCoordinatingController: MovieSearchViewControllerDelegate {
    func searchStarted() {
        showLoader()
    }
    
    func searchFinished(with result: MoviesList) {
        hideLoader()
        result.totalResults > 0 ? showSearchResults(result) : showEmptySearchStub()
    }
    
    func resultsLayoutChanged(to layout: SearchResultsLayout) {}
}
