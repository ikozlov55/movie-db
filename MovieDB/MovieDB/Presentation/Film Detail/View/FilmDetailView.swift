//
//  FilmDetailView.swift
//  MovieDB
//
//  Created by Илья Козлов on 11.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Корневая `view` модуля подробной информации о фильме
final class FilmDetailView: UIView {
    
    // MARK: - Subviews
    
    let posterView = PosterView()
    
    let titleLabel = SubtitleLabel()
    
    let subtitleLabel = DarkDescriptionLabel()
    
    let genresLabel = LightDescriptionLabel()
    
    let ratingTitle = DarkDescriptionLabel(L10n.filmRaiting)
    
    let ratingLabel = SubtitleLabel()
    
    let votesCountLabel = DarkDescriptionLabel()
    
    let runtimeTitle = DarkDescriptionLabel(L10n.filmRuntime)
    
    let runtimeLabel = SubtitleLabel()
    
    let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorName.darkBlue.color
        return view
    }()
    
    let scroll: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.indicatorStyle = .white
        return view
    }()
    
    let descriptionLabel = SubtitleLabel()
        
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
        layoutMargins = UIEdgeInsets(top: 8, left: 24, bottom: 0, right: 24)
        setupMainInfoArea()
        setupDescriptionArea()
    }
    
    private func setupMainInfoArea() {
        addSubviews(posterView, titleLabel, subtitleLabel,
                    genresLabel, runtimeTitle, runtimeLabel,
                    ratingTitle, ratingLabel, votesCountLabel)
        
        let inset: CGFloat = 24
        let margins = layoutMarginsGuide
        let posterWidth: CGFloat = 120
        let posterHeight: CGFloat = 180
        let innerInset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: margins.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            posterView.widthAnchor.constraint(equalToConstant: posterWidth),
            posterView.heightAnchor.constraint(equalToConstant: posterHeight),
            
            titleLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: innerInset),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: margins.trailingAnchor, constant: -innerInset),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: innerInset),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: margins.trailingAnchor, constant: -innerInset),
            
            genresLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            genresLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: innerInset),
            genresLabel.trailingAnchor.constraint(lessThanOrEqualTo: margins.trailingAnchor, constant: -innerInset),
            
            runtimeTitle.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: inset),
            runtimeTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            
            runtimeLabel.topAnchor.constraint(equalTo: runtimeTitle.bottomAnchor, constant: 6),
            runtimeLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            
            ratingTitle.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: inset),
            ratingTitle.leadingAnchor.constraint(equalTo: runtimeTitle.trailingAnchor, constant: 40),
            
            ratingLabel.topAnchor.constraint(equalTo: ratingTitle.bottomAnchor, constant: 6),
            ratingLabel.leadingAnchor.constraint(equalTo: runtimeTitle.trailingAnchor, constant: 40),
            
            votesCountLabel.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            votesCountLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 5)
        ])
    }
    
    private func setupDescriptionArea() {
        addSubviews(separator, scroll)
        scroll.addSubview(descriptionLabel)

        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 80),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            scroll.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 21),
            scroll.leadingAnchor.constraint(equalTo: leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: scroll.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: scroll.bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scroll.contentSize.height = descriptionLabel.intrinsicContentSize.height * 2
    }
}
