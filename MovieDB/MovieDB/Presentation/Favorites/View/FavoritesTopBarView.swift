//
//  FavoritesTopBarView.swift
//  MovieDB
//
//  Created by Илья Козлов on 12.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class FavoritesTopBarView: UIView {

    // MARK: - Subviews
    
    let header = HeaderLabel(L10n.favoriteTitle)
    
    let searchIcon = SearchIconView()
    
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
        addSubviews(header, searchIcon, layoutSwitch)
        let safeArea = safeAreaLayoutGuide
        let inset: CGFloat = 24
        let topInset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            layoutSwitch.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: topInset),
            layoutSwitch.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset),
            
            searchIcon.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: topInset),
            searchIcon.trailingAnchor.constraint(equalTo: layoutSwitch.leadingAnchor, constant: -inset),
                        
            header.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 91),
            header.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            header.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -inset)
        ])
    }
}
