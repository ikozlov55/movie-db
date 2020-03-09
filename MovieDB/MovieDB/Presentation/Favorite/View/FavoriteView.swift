//
//  FavoriteView.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class FavoriteView: UIView {
    
    // MARK: - Subviews

    let header = HeaderLabel(L10n.favoriteTitle)
    
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
        addSubview(header)
        
        let safeArea = safeAreaLayoutGuide
        let inset: CGFloat = 24
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 91),
            header.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            header.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -inset)
        ])
    }
}
