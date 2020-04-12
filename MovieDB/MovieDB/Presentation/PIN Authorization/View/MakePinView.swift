//
//  MakePinView.swift
//  MovieDB
//
//  Created by Илья Козлов on 06.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Корневая `view` экрана создания PIN кода
class MakePinView: UIView {
    
    // MARK: - Subviews
    
    let backArrow = BackArrowView()
    
    let title: HeaderLabel = {
        let label = HeaderLabel(L10n.enterNewPinTitle)
        label.textAlignment = .center
        return label
    }()
    
    let inputIndicator = NumpadIndicator()
    
    let numpad: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Private Properties
    
    private lazy var numpadDataSource = NumpadDataSource()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupNumPad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupNumPad()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        addSubview(backArrow)
        addSubview(title)
        addSubview(inputIndicator)
        addSubview(numpad)
        inputIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let inset: CGFloat = 40
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            backArrow.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: inset / 2),
            backArrow.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset / 2),
            
            title.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 80),
            title.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            title.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset),
            
            inputIndicator.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25),
            inputIndicator.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            inputIndicator.widthAnchor.constraint(equalToConstant: frame.width / 3),
            inputIndicator.heightAnchor.constraint(equalToConstant: 8),
            
            numpad.topAnchor.constraint(equalTo: inputIndicator.bottomAnchor, constant: 30),
            numpad.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            numpad.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset),
            numpad.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -inset)
        ])
    }
    
    private func setupNumPad() {
        numpad.register(NumpadButtonCell.self, forCellWithReuseIdentifier: NumpadButtonCell.identifier)
        numpad.dataSource = numpadDataSource
        numpad.delegate = self
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MakePinView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let diameter = numpad.frame.width / 3 - 20

        return CGSize(width: diameter, height: diameter)
    }
}
