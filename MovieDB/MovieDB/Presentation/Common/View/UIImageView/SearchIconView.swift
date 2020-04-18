//
//  SearchIconView.swift
//  MovieDB
//
//  Created by Илья Козлов on 12.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Иконка поиска
final class SearchIconView: BaseIconView {

    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        image = Asset.search.image
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
