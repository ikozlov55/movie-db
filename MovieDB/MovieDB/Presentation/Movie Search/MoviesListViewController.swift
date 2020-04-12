//
//  MoviesListViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Тип, ответственный за отображение найденных в поиске фильмов
protocol MoviesListViewControllerProtocol: UIViewController {
    
    /// `MoviesListViewControllerDelegate` который обрабатывает взаимодействие со списком
    var delegate: MoviesListViewControllerDelegate? { get set }
    
    /// Отображение фильмов в `UICollectionView`
    /// - Parameter movies: Список `MovieViewModel` найденных фильмов
    func show(_ movies: [MovieViewModel])
}

/// Тип, который обрабатывает взаимодействие со списком найденных фильмов
protocol MoviesListViewControllerDelegate: class {
    func listItemTapped(_ movie: MovieViewModel)
}

/// `ViewController` в котором в `UICollectionView` отображается список найденных фильмов
final class MoviesListViewController: BaseViewController, MoviesListViewControllerProtocol {
    
    // MARK: - Public Properties
    
    weak var delegate: MoviesListViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private var moviesListView = MoviesListView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = moviesListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesListView.collectionView.delegate = self
    }
    
    // MARK: - Public methods
    
    /// Отображение фильмов в `UICollectionView`
    /// - Parameter movies: Список `MovieViewModel` найденных фильмов
    func show(_ movies: [MovieViewModel]) {
        moviesListView.dataSource.movieViewModels = movies
        moviesListView.collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDelegate

extension MoviesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = moviesListView.dataSource.movieViewModels[indexPath.row]
        delegate?.listItemTapped(movie)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 120)
    }
}
