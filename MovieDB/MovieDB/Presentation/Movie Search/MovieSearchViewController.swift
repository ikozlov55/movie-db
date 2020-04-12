//
//  FilmSearchViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 28.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Тип расположения результатов поиска фильмов: списком или крупными виджетами
enum SearchResultsLayout {
    case list
    case widgets
}

/// `UIViewController` который выполняет поиск по базе themoviedb.org и оповещает свой делегат о результатах
protocol MovieSearchViewControllerProtocol: UIViewController {
    
    /// `MovieSearchViewControllerDelegate` который оповещается о результатх поиска
    var delegate: MovieSearchViewControllerDelegate? { get set }
    
    /// Поиск фильмов по базе themoviedb.org
    /// - Parameter query: Поисковый запрос
    func search(query: String, page: Int)
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

final class MovieSearchViewController: BaseViewController, MovieSearchViewControllerProtocol {
    
    // MARK: - Public Properties
    
    weak var delegate: MovieSearchViewControllerDelegate?
    
    // MARK: - Private Properties
    private var layout: SearchResultsLayout = .list
    private var movieSearchView = MovieSearchView()
    private let searchService = ServiceLayer.searchService
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = movieSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInteractions()
    }
    
    // MARK: - Public methods
    
    func search(query: String, page: Int) {
        delegate?.searchStarted()
        searchService.search(query: query, page: page) { [weak self] result in
            switch result {
            case .success(let moviesList):
                self?.delegate?.searchFinished(with: moviesList)
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Methods
    
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

// MARK: - UISearchBarDelegate
extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.trim.count > 3 else { return }
        search(query: searchText, page: 1)
    }
}
