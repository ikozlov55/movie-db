//
//  MovieSearchStartView.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class MovieSearchStartView: UIView {

    // MARK: - Subviews

    let header = HeaderLabel(L10n.filmSearchTitle)
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = Asset.mainBackground.image
        view.contentMode = .scaleAspectFit
        return view
    }()
    let searchBar = MovieSearchBar()
    
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
        addSubview(backgroundImageView)
        addSubview(header)
        addSubview(searchBar)
        
        let safeArea = safeAreaLayoutGuide
        let inset: CGFloat = 24
        
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            header.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 91),
            header.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            header.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -inset),
            
            searchBar.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 33),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            searchBar.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -inset)
        ])
    }

}
