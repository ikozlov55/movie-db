//
//  MoviesListViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `ViewController` в котором в `UICollectionView` отображается список найденных фильмов
final class MoviesListViewController: BaseViewController {
    
    // MARK: - Private Properties
    
    private var moviesListView = MoviesListView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = moviesListView
    }
    
    // MARK: - Public methods
    
    /// Отображение фильмов в `UICollectionView`
    /// - Parameter movies: Список `MovieViewModel` найденных фильмов
    func show(_ movies: [MovieViewModel]) {
        moviesListView.dataSource.movieViewModels = movies
        moviesListView.collectionView.reloadData()
    }
    
}
