//
//  NumpadButtonCell.swift
//  MovieDB
//
//  Created by Илья Козлов on 06.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Перечисление возможных типов кнопок на клавиатуре ввода ПИН кода
enum NumpadButtonType {
    case number(_ value: Int)
    case backspace
}

/// Сабкласс `UICollectionViewCell`,  кнопка на клавиатуре ввода ПИН кода
class NumpadButtonCell: UICollectionViewCell {

    // MARK: - Subviews
    let numberLabel = HeaderLabel()

    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

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
        setupCellAppearance()
        setupSubviews()
    }

    private func setupCellAppearance() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        backgroundColor = ColorName.red.color
    }

    private func setupSubviews() {
        addSubviews(numberLabel, imageView)
        center(numberLabel)
        center(imageView)
    }

    // MARK: - Public methods

    /// Отображение в ячейке
    /// - Parameter type: <#type description#>
    func present(_ type: NumpadButtonType) {
        switch type {
        case .number(let value):
            numberLabel.text = String(describing: value)
            imageView.isHidden = true
        case .backspace:
            imageView.image = Asset.numpadBackspace.image
            numberLabel.isHidden = true
        }
    }
    
}
