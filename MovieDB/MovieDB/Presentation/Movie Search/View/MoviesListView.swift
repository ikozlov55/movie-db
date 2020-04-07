//
//  MoviesListView.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Корневая `view` модуля отображения результата поиска фильмов
final class MoviesListView: UIView {
    
    // MARK: - Public Properties
    
    var dataSource = MovieListDataSource()
    
    // MARK: - Private Properties
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    // MARK: - Subviews
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.indicatorStyle = UIScrollView.IndicatorStyle.white
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        setupLayout()
        setupCollectionView()
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: margins.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.register(
            MovieListCell.self,
            forCellWithReuseIdentifier: MovieListCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = dataSource
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesListView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 120)
    }
}
