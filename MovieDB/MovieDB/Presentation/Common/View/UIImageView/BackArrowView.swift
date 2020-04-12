//
//  BackArrowView.swift
//  MovieDB
//
//  Created by Илья Козлов on 11.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Иконка в виде стрелочки - навигация на прошлый экран
final class BackArrowView: BaseIconView {

    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        image = Asset.arrowBack.image
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
