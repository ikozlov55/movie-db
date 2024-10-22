//
//  FilmDetailCoordinatingController.swift
//  MovieDB
//
//  Created by Илья Козлов on 12.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `CoordinatingController` экрана детальной информации о фильме
final class FilmDetailCoordinatingController: BaseViewController {
    
    // MARK: - Public Properties
    
    var coordinator: FilmsTabCoordinator?
    
    // MARK: - Private Properties
    
    private let accountService = ServiceLayer.accountService
    
    private let movie: MovieViewModel
    
    private var isFavorite: Bool = false
    
    private let topBarViewController: FilmDetailTopBarViewControllerProtocol
    
    private let detailViewController: FilmDetailViewControllerProtocol
    
    private let loader = LoadingViewController()
    
    // MARK: - Init
    
    init(_ movie: MovieViewModel) {
        self.movie = movie
        topBarViewController = FilmDetailTopBarViewController()
        detailViewController = FilmDetailViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopBar()
        setFavoriteIcon()
        setupDetailView()
        topBarViewController.delegate = self
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
            topBarViewController.view.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setFavoriteIcon() {
        accountService.isFavorite(movieId: movie.id) { [weak self] result in
            switch result {
            case .success(let status):
                self?.isFavorite = status
                self?.topBarViewController.setFavoriteIcon(active: status)
            case .failure:
                return
            }
        }
    }
    
    private func setupDetailView() {
        addChildToContentArea(detailViewController)
        detailViewController.present(movie: movie)
    }
    
    private func showLoader() {
        addChildToContentArea(loader)
    }
    
    private func hideLoader() {
        loader.remove()
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

// MARK: - FilmDetailTopBarViewControllerDelegate

extension FilmDetailCoordinatingController: FilmDetailTopBarViewControllerDelegate {
    func arrowBackTapped() {
        coordinator?.back()
    }
    
    func favoriteIconTapped() {
        let handler: (Result<Bool, Error>) -> Void = { result in
            switch result {
            case .success:
                self.isFavorite.toggle()
                self.topBarViewController.toogleFavoriteIcon()
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
            self.hideLoader()
        }
        showLoader()
        
        if !isFavorite {
            accountService.addToFavorites(mediaId: movie.id, completion: handler)
        } else {
            accountService.removeFromFavorites(mediaId: movie.id, completion: handler)
        }
        
    }
    
}
