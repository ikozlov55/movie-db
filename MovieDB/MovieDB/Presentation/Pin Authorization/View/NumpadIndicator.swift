//
//  NumpadIndicator.swift
//  MovieDB
//
//  Created by Илья Козлов on 06.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Цветовая схема индикатора ввода символов пин-кода
enum NumpadIndicatorColorScheme {
    case input
    case error
}

/// Индикатор ввода символов пин-кода
final class NumpadIndicator: UIPageControl {
    
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
        currentPage = 0
        numberOfPages = 4
        setColorScheme(.input)
    }
    
    // MARK: - Public methods
    
    /// Установка цветовой схемы индикатора
    /// - Parameter scheme: Тип цветовой схемы, который необходимо отобразить
    func setColorScheme(_ scheme: NumpadIndicatorColorScheme) {
        switch scheme {
        case .input:
            pageIndicatorTintColor = ColorName.gray.color
            currentPageIndicatorTintColor = ColorName.purpure.color
        case .error:
            pageIndicatorTintColor = ColorName.red.color
            currentPageIndicatorTintColor = ColorName.red.color
        }
    }
    
}
