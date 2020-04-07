//
//  BaseLabel.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Базовый  класс для создания конкретных `UILabel`, в инициализаторе производит общую первичную настройку
class BaseLabel: UILabel {
    
    // MARK: - Init
    
    /// Базовый инициализатор
    /// - Parameters:
    ///   - fontSize: Размер шрифта
    ///   - weight: Вес шрифта
    ///   - color: Цвет текста
    ///   - text: Текст
    init(fontSize: CGFloat, weight: UIFont.Weight, color: UIColor, text: String) {
        super.init(frame: .zero)
        setupView()
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.text = text
    }
    
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
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
    }
    
}
