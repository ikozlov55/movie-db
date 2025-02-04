//
//  LightDescriptionLabel.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Светлый `UILabel` для отображения деталей описания фильма
/// Цвет: lightBlue
/// Вес шрифта: medium
/// Размер шрифта: 12
final class LightDescriptionLabel: BaseLabel {

    // MARK: - Init
    
    init(_ text: String = "") {
        let color = ColorName.lightBlue.color
        super.init(fontSize: 12, weight: .medium, color: color, text: text)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
