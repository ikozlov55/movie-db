//
//  LayoutSwitchView.swift
//  MovieDB
//
//  Created by Илья Козлов on 12.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Иконка переключения типа расположения фильмов в списке
class LayoutSwitchView: BaseIconView {

    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        image = Asset.collectionLayoutList.image
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
