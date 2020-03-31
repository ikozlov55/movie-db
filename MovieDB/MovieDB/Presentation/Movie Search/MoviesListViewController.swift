//
//  MoviesListViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class MoviesListViewController: BaseViewController {

    // MARK: - Private Properties
    
    private var moviesListView = MoviesListView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = moviesListView
    }
    
    // MARK: - Public methods
    
    func show(_ movies: [MovieVM]) {
        moviesListView.dataSource.data = movies
        moviesListView.collectionView.reloadData()
    }

}
