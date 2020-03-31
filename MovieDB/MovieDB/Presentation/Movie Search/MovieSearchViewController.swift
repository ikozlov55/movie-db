//
//  FilmSearchViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 28.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Тип расположения результатов поиска фильмов: списоком или крупными виджетами
enum SearchResultsLayout {
    case list
    case widgets
}

/// Тип, который обрабатывает результаты поиск фильмов
protocol MovieSearchViewControllerDelegate: class {
    
    /// Обработка изменения типа расположения результатов поиска
    /// - Parameter layout: Тип расположения
    func resultsLayoutChanged(to layout: SearchResultsLayout)
    
    /// Обработка начала поиска
    func searchStarted()
    
    /// Обработка результатов поиск
    /// - Parameter result: Страница результатов поиска типа `MoviesList`
    func searchFinished(with result: MoviesList)
}

final class MovieSearchViewController: BaseViewController {
    
    // MARK: - Public Properties
    
    var layout: SearchResultsLayout!
    weak var delegate: MovieSearchViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private var movieSearchView = MovieSearchView()
    private let searchService = ServiceLayer.searchService
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = movieSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupInteractions()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        layout = .list
        movieSearchView.layoutSwitch.image = Asset.collectionLayoutList.image
    }
    
    private func setupInteractions() {
        movieSearchView.searchBar.delegate = self
        movieSearchView.searchBar.becomeFirstResponder()
        let layoutSwitchTap = UITapGestureRecognizer(target: self, action: #selector(layoutSwitchTapped))
        movieSearchView.layoutSwitch.addGestureRecognizer(layoutSwitchTap)
    }
    
    @objc private func layoutSwitchTapped() {
        if layout == .list {
            layout = .widgets
            movieSearchView.layoutSwitch.image = Asset.collectionLayoutWidgets.image
            delegate?.resultsLayoutChanged(to: .widgets)
        } else {
            layout = .list
            movieSearchView.layoutSwitch.image = Asset.collectionLayoutList.image
            delegate?.resultsLayoutChanged(to: .list)
        }
        
    }
    
}

extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.trim.count > 3 else { return }
        delegate?.searchStarted()
        searchService.search(query: searchText) { [weak self] result in
            switch result {
            case .success(let moviesList):
                self?.delegate?.searchFinished(with: moviesList)
            case .failure(let error):
                print(error)
            }
        }
    }
}
