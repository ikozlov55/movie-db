//
//  FilmSearchView.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final class FilmSearchView: UIView {

    // MARK: - Subviews

    let header = HeaderLabel(L10n.filmSearchTitle)
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = Asset.mainBackground.image
        view.contentMode = .scaleAspectFit
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
        addSubview(backgroundImageView)
        addSubview(header)
        
        let safeArea = safeAreaLayoutGuide
        let inset: CGFloat = 24
        
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            header.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 91),
            header.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            header.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -inset)
        ])
    }

}
