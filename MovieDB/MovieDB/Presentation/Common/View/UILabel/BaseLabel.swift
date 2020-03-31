//
//  BaseLabel.swift
//  MovieDB
//
//  Created by Илья Козлов on 08.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    // MARK: - Init
    
    init(size: CGFloat, weight: UIFont.Weight, color: UIColor, text: String) {
        super.init(frame: .zero)
        setupView()
        textColor = color
        font = UIFont.systemFont(ofSize: size, weight: weight)
        self.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
    }
    
}
