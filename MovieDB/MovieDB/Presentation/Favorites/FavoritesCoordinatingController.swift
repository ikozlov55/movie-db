//
//  FavoritesCoordinatingController.swift
//  MovieDB
//
//  Created by Илья Козлов on 12.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `CoordinatingController` флоу экрана Избранное'
final class FavoritesCoordinatingController: BaseViewController {

    // MARK: - Public Properties
    
    var coordinator: FavoritesTabCoordinator?
    
    // MARK: - Private Properties
    
    private let loader = LoadingViewController()
    
    private let accountService = ServiceLayer.accountService
    
    private let topBarViewController: FavoritesTopBarViewControllerProtocol
    
    private let moviesListController: MoviesListViewControllerProtocol
    
    private let storageService = ServiceLayer.storageService
    
    // MARK: - Init
    
    init() {
        topBarViewController = FavoritesTopBarViewController()
        moviesListController = MoviesListViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showFavoritesList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopBar()
    }
    
    // MARK: - Private Methods
    
    private func setupTopBar() {
        add(child: topBarViewController)
        let safeArea = view.safeAreaLayoutGuide
        topBarViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topBarViewController.view.topAnchor.constraint(equalTo: safeArea.topAnchor),
            topBarViewController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            topBarViewController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            topBarViewController.view.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func showFavoritesList() {
        showMovies(storageService.read())
        //showLoader()
        accountService.getFavorites { [weak self] result in
            switch result {
            case .success(let moviesList):
                self?.showMovies(moviesList.results)
                self?.storageService.save(moviesList.results)
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
            }
            //self?.hideLoader()
        }
    }
    
    private func showLoader() {
        addChildToContentArea(loader)
    }
    
    private func hideLoader() {
        loader.remove()
    }
    
    private func showMovies(_ movies: [Movie]) {
        addChildToContentArea(moviesListController)
        let movieViewModels = movies.map { MovieViewModelTransformer.viewModel(from: $0) }
        moviesListController.show(movieViewModels)
    }
    
    private func addChildToContentArea(_ viewController: UIViewController) {
        add(child: viewController)
        let safeArea = view.safeAreaLayoutGuide
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: topBarViewController.view.bottomAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}
