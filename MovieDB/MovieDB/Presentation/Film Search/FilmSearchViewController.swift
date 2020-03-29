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
protocol FilmSearchViewControllerDelegate: class {
    
    /// Обработка изменения типа расположения результатов поиска
    /// - Parameter layout: Тип расположения
    func resultsLayoutChanged(to layout: SearchResultsLayout)
}

final class FilmSearchViewController: BaseViewController {
    
    // MARK: - Public Properties
    
    var layout: SearchResultsLayout!
    weak var delegate: FilmSearchViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private var filmSearchView = FilmSearchView()
    private let searchService = ServiceLayer.searchService
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = filmSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupInteractions()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        layout = .list
        filmSearchView.layoutSwitch.image = Asset.collectionLayoutList.image
    }
    
    private func setupInteractions() {
        filmSearchView.searchBar.delegate = self
        filmSearchView.searchBar.becomeFirstResponder()
        let layoutSwitchTap = UITapGestureRecognizer(target: self, action: #selector(layoutSwitchTapped))
        filmSearchView.layoutSwitch.addGestureRecognizer(layoutSwitchTap)
    }
    
    @objc private func layoutSwitchTapped() {
        if layout == .list {
            layout = .widgets
            filmSearchView.layoutSwitch.image = Asset.collectionLayoutWidgets.image
            delegate?.resultsLayoutChanged(to: .widgets)
        } else {
            layout = .list
            filmSearchView.layoutSwitch.image = Asset.collectionLayoutList.image
            delegate?.resultsLayoutChanged(to: .list)
        }
        
    }
    
}

extension FilmSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.trim.count > 3 else { return }
        searchService.search(query: searchText) { result in
            switch result {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
}
