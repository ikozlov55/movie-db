//
//  AddFavoriteView.swift
//  MovieDB
//
//  Created by Илья Козлов on 12.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Иконка для добавления/удаления фильма в избранное
final class AddFavoriteView: UIImageView {
    
    // MARK: - Public Properties
    
    /// Признак наличия фильма в списке избранного
    var isFavorite: Bool = false {
        didSet {
            image = isFavorite ? Asset.favoriteEnabled.image : Asset.favoriteDisabled.image
        }
    }

    // MARK: - Init
    
    init(isFavorite: Bool = false) {
        super.init(frame: .zero)
        setupView()
    }
    
    override init(frame: CGRect) {
        self.isFavorite = false
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
        isUserInteractionEnabled = true
        isFavorite = false
    }
}
