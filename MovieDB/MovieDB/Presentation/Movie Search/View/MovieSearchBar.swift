//
//  MovieSearchBar.swift
//  MovieDB
//
//  Created by Илья Козлов on 28.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Сабкласс `UISearchBar` для экрана поиска по фильмам и избранному
final class MovieSearchBar: UISearchBar {

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
        searchBarStyle = .minimal
        tintColor = ColorName.lightBlue.color
        setupTextField()
        setupIcons()
    }
    
    private func setupTextField() {
        searchTextField.backgroundColor = ColorName.tabBarBlue.color
        searchTextField.textColor = ColorName.lightBlue.color
        searchTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        searchTextField.layer.cornerRadius = 8
        placeholder = L10n.filmSearchBarPlaceholder
        autocapitalizationType = .none
    }
    
    private func setupIcons() {
        setImage(Asset.search.image, for: .search, state: .normal)
        setImage(Asset.searchClear.image, for: .clear, state: .normal)
    }
    
}
