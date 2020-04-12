//
//  PosterView.swift
//  MovieDB
//
//  Created by Илья Козлов on 11.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `UIImageView` для отображен я постера фильма
class PosterView: UIImageView {

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
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = .gray
    }
    
}
