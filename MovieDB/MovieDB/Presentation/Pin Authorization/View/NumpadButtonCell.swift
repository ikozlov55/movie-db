//
//  NumpadButtonCell.swift
//  MovieDB
//
//  Created by Илья Козлов on 06.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Перечисление возможных типов кнопок на клавиатуре ввода пин-кода
enum NumpadButtonType {
    case number(_ value: Int)
    case backspace
    case placeholder
    case exit
    case faceId
}

/// Сабкласс `UICollectionViewCell`,  кнопка на клавиатуре ввода пин-кода
class NumpadButtonCell: UICollectionViewCell {
    
    // MARK: - Subviews
    let numberLabel = HeaderLabel()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let textLabel = DarkDescriptionLabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.isHidden = true
        numberLabel.isHidden = true
        textLabel.isHidden = true
        isUserInteractionEnabled = true
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        setupCellAppearance()
        setupSubviews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    private func setupCellAppearance() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
    
    private func setupSubviews() {
        addSubviews(numberLabel, imageView, textLabel)
        center(numberLabel)
        center(imageView)
        center(textLabel)
    }
    
    // MARK: - Public methods
    
    /// Отображение в ячейке кнопки указанного типа
    /// - Parameter type: Тип отображаемой ячейки
    func present(_ type: NumpadButtonType) {
        switch type {
        case .number(let value):
            numberLabel.isHidden = false
            numberLabel.text = String(describing: value)
        case .backspace:
            imageView.isHidden = false
            imageView.image = Asset.numpadBackspace.image
        case .placeholder:
            isUserInteractionEnabled = false
        case .exit:
            textLabel.isHidden = false
            textLabel.text = L10n.logutNumpadButtonText
        case .faceId:
            imageView.isHidden = false
            imageView.image = Asset.numpadFaceId.image
        }
    }
    
    // MARK: - Touches Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.15) {
            self.backgroundColor = ColorName.red.color
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.15) {
            self.backgroundColor = .clear
        }
        super.touchesEnded(touches, with: event)
    }
    
    @objc private func cellTapped() {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            options: [.allowUserInteraction],
            animations: {
                self.backgroundColor = ColorName.red.color
            },
            completion: { _ in
                self.backgroundColor = .clear
            }
        )
    }
}
