//
//  NumpadButtonCell.swift
//  MovieDB
//
//  Created by Илья Козлов on 06.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Сабкласс `UICollectionViewCell`,  кнопка на клавиатуре ввода ПИН кода
class NumpadButtonCell: UICollectionViewCell {
    
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
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        backgroundColor = ColorName.red.color
    }
    
}
