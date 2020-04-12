//
//  FilmDetailTopBarView.swift
//  MovieDB
//
//  Created by Илья Козлов on 12.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Корневая `view` модуля навигации на экране информации о фильме
final class FilmDetailTopBarView: UIView {
    
    // MARK: - Subviews
    
    let backArrow = BackArrowView()
    
    let favoriteIcon = AddFavoriteView()
    
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
        addSubview(backArrow)
        addSubview(favoriteIcon)
        let safeArea = safeAreaLayoutGuide
        let topInset: CGFloat = 20
        let inset: CGFloat = 24
        NSLayoutConstraint.activate([
            backArrow.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: topInset),
            backArrow.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            
            favoriteIcon.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: topInset),
            favoriteIcon.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset)
        ])
    }
    
}
