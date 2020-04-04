//
//  EmptySearchResultsView.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Корневая `view` модуля заглушки для пустого результата поиска
final class EmptySearchResultsView: UIView {
    // MARK: - Subviews
    
    private let header = SubtitleLabel(L10n.filmNotFoundTitle)
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = Asset.filmNotFoundBackground.image
        view.contentMode = .scaleAspectFit
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
        addSubview(backgroundImageView)
        addSubview(header)
        
        let inset: CGFloat = 24
        let imageSize: CGFloat = 300
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            header.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -inset),
            
            backgroundImageView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: inset * 2),
            backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: imageSize),
            backgroundImageView.heightAnchor.constraint(equalToConstant: imageSize)
        ])
    }
    
}
