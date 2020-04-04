//
//  SubtitleLabel.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Основной`UILabel` приложения: подзаголовки, текст полей ввода и т.д.
/// Цвет: lightBlue
/// Вес шрифта: regular
/// Размер шрифта: 16
final class SubtitleLabel: BaseLabel {

    // MARK: - Init
    
    init(_ text: String = "") {
        let color = ColorName.lightBlue.color
        super.init(fontSize: 16, weight: .regular, color: color, text: text)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
