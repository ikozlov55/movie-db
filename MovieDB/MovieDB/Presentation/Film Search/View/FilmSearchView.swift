//
//  FilmSearchView.swift
//  MovieDB
//
//  Created by Илья Козлов on 28.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class FilmSearchView: UIView {
    
    // MARK: - Subviews
    let searchBar = FilmSearchBar()
    let layoutSwitch: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
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
        addSubview(searchBar)
        addSubview(layoutSwitch)
        
        let inset: CGFloat = 24
        
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
