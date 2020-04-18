//
//  FilmSearchView.swift
//  MovieDB
//
//  Created by Илья Козлов on 28.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `UIView` с полем поиска и переключателем типа  расположения результатов
final class MovieSearchView: UIView {
    
    // MARK: - Subviews
    let searchBar = MovieSearchBar()
    let layoutSwitch = LayoutSwitchView()
    
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
        addSubviews(searchBar, layoutSwitch)

        let inset: CGFloat = 24

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            
            layoutSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            layoutSwitch.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: inset),
            layoutSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset)
        ])
    }
    
}
