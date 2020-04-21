//
//  PinAuthorizationHeaderView.swift
//  MovieDB
//
//  Created by Илья Козлов on 18.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Корневая `view` модуля  с индикатором ввода на экране ввода пин-кода
final class PinAuthorizationHeaderView: UIView {
    
    // MARK: - Subviews
    
    let backArrow = BackArrowView()
    
    let title: HeaderLabel = {
        let label = HeaderLabel()
        label.textAlignment = .center
        return label
    }()
    
    let inputIndicator = NumpadIndicator()
    
    let errorLabel = ErrorLabel()
    
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
        addSubviews(backArrow, title, inputIndicator, errorLabel)
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
            
            errorLabel.topAnchor.constraint(equalTo: inputIndicator.bottomAnchor, constant: 10),
            errorLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
}
