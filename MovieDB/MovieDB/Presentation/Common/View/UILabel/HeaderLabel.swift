//
//  HeaderLabel.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Крупный `UILabel` для заголовков экранов
/// Цвет: lightBlue
/// Вес шрифта: medium
/// Размер шрифта: 32
final class HeaderLabel: BaseLabel {

    // MARK: - Init
    
    init(_ text: String = "") {
        let color = ColorName.lightBlue.color
        super.init(fontSize: 32, weight: .medium, color: color, text: text)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
