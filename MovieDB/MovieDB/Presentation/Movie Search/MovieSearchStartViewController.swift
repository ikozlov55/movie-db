//
//  MovieSearchStartViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Тип, который обрабатывает старт пользовательского ввода на первом экране флоу поиска фильмов
protocol MovieSearchStartViewControllerDelegate: class {
    
    /// Обработка начала пользовательского ввода
    func searchDidStarted()
}

final class MovieSearchStartViewController: BaseViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: MovieSearchStartViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private var movieSearchStartView = MovieSearchStartView()
    private let searchService = ServiceLayer.searchService
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = movieSearchStartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchStartView.searchBar.delegate = self
        searchService.genres(completion: nil)
    }
    
}

// MARK: - UISearchBarDelegate

extension MovieSearchStartViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseIn,
            animations: { [weak self] in
                guard let self = self else { return }
                self.movieSearchStartView.backgroundImageView.alpha = 0
                self.movieSearchStartView.header.removeFromSuperview()
                NSLayoutConstraint.activate([
                    self.movieSearchStartView.searchBar.topAnchor.constraint(
                        equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                        constant: 24)
                ])
                self.movieSearchStartView.layoutIfNeeded()
            },
            completion: { [weak self] _ in
                self?.movieSearchStartView.backgroundImageView.removeFromSuperview()
                self?.delegate?.searchDidStarted()
            })
    }
}
