//
//  PinAuthorizationNumpadView.swift
//  MovieDB
//
//  Created by Илья Козлов on 18.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Корневая `view` модуля клавиатуры ввода на экране ввода пин-кода
final class PinAuthorizationNumpadView: UIView {
    
    // MARK: - Subviews
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
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
        setupLayout()
        collectionView.register(NumpadButtonCell.self, forCellWithReuseIdentifier: NumpadButtonCell.identifier)
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        let inset: CGFloat = 40
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }
    
}
