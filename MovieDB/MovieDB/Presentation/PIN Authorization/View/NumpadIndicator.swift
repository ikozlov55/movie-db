//
//  NumpadIndicator.swift
//  MovieDB
//
//  Created by Илья Козлов on 06.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Индикатор ввода символов ПИН кода
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
        pageIndicatorTintColor = ColorName.gray.color
        currentPageIndicatorTintColor = ColorName.purpure.color
    }
    
}
