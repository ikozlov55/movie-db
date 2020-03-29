//
//  FilmSearchWelcomeViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Тип, который обрабатывает старт пользовательского ввода на первом экране флоу поиска фильмов
protocol FilmSearchWelcomeViewControllerDelegate: class {
    
    /// Обработка начала пользовательского ввода
    func searchDidStarted()
}

final class FilmSearchWelcomeViewController: BaseViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: FilmSearchWelcomeViewControllerDelegate?
    
    // MARK: - Private Properties

    private var filmSearchWelcomeView = FilmSearchWelcomeView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = filmSearchWelcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmSearchWelcomeView.searchBar.delegate = self
    }

}

// MARK: - UISearchBarDelegate

extension FilmSearchWelcomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.searchDidStarted()
    }
}
