//
//  MovieSearchBar.swift
//  MovieDB
//
//  Created by Илья Козлов on 28.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

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
        translatesAutoresizingMaskIntoConstraints = false
        searchTextField.backgroundColor = ColorName.tabBarBlue.color
        searchTextField.textColor = ColorName.lightBlue.color
        searchTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        searchTextField.layer.cornerRadius = 8
        setImage(Asset.search.image, for: .search, state: .normal)
        setImage(Asset.searchClear.image, for: .clear, state: .normal)
        tintColor = ColorName.lightBlue.color
        searchBarStyle = .minimal
        placeholder = L10n.filmSearchBarPlaceholder
        autocapitalizationType = .none
    }
    
}
