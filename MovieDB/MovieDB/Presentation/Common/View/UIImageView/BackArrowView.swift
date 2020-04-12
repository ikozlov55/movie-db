//
//  BackArrowView.swift
//  MovieDB
//
//  Created by Илья Козлов on 11.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `UIImageView` - изображение стрелочки - навигация на прошлый экран
class BackArrowView: UIImageView {

    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupView()
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
        isUserInteractionEnabled = true
        image = Asset.arrowBack.image
    }

}
