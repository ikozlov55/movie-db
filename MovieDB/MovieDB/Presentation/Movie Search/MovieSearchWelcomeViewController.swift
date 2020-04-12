//
//  MovieSearchWelcomeViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Тип, который обрабатывает старт пользовательского ввода на первом экране флоу поиска фильмов
protocol MovieSearchWelcomeViewControllerDelegate: class {
    
    /// Обработка начала пользовательского ввода
    func searchBarTaped()
}

final class MovieSearchWelcomeViewController: BaseViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: MovieSearchWelcomeViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private var movieSearchStartView = MovieSearchWelcomeView()
    private let searchService = ServiceLayer.searchService
    private let accountService = ServiceLayer.accountService
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = movieSearchStartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchStartView.searchBar.delegate = self
        searchService.getGenres(completion: nil)
        accountService.getAccountData(completion: nil)
    }
    
}

// MARK: - UISearchBarDelegate

extension MovieSearchWelcomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        movieSearchStartView.header.removeFromSuperview()
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.movieSearchStartView.backgroundImageView.alpha = 0
                self.movieSearchStartView.searchBar.topAnchor.constraint(
                    equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                    constant: 24).isActive = true
                self.movieSearchStartView.layoutIfNeeded()
            },
            completion: { _ in
                self.movieSearchStartView.backgroundImageView.removeFromSuperview()
                self.delegate?.searchBarTaped()
            })
    }
}
