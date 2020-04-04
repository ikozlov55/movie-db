//
//  MovieListCell.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Сабкласс `UICollectionViewCell` для отображения моделей `MovieViewModel` в виде списка
final class MovieListCell: UICollectionViewCell {
    
    // MARK: - Subviews
    
    private let posterView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .gray
        return view
    }()
    
    private let runtimeIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = Asset.filmRuntime.image
        return view
    }()
    
    private let titleLabel: SubtitleLabel = {
        let label = SubtitleLabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let subtitleLabel: DarkDescriptionLabel = {
        let label = DarkDescriptionLabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let genresLabel: LightDescriptionLabel = {
        let label = LightDescriptionLabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let ratingLabel = SubtitleLabel()
    
    private let votesCountLabel = DarkDescriptionLabel()
    
    private let runtimeLabel = LightDescriptionLabel()
    
    // MARK: - Public Properties
    
    /// Прогресс загрузки изображения с постером фильма
    var progress: Progress?
    
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
        addSubview(posterView)
        addSubview(runtimeIcon)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(genresLabel)
        addSubview(ratingLabel)
        addSubview(votesCountLabel)
        addSubview(runtimeLabel)
        
        let margins = layoutMarginsGuide
        let posterWidth: CGFloat = 80
        let posterHeight: CGFloat = 120
        let inset: CGFloat = 8
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: margins.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            posterView.widthAnchor.constraint(equalToConstant: posterWidth),
            posterView.heightAnchor.constraint(equalToConstant: posterHeight),
            
            titleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: inset),
            titleLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: inset),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: margins.trailingAnchor, constant: -inset),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: inset),
            subtitleLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: inset),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: margins.trailingAnchor, constant: -inset),
            
            genresLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: inset),
            genresLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: inset),
            genresLabel.trailingAnchor.constraint(lessThanOrEqualTo: margins.trailingAnchor, constant: -inset),
            
            ratingLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: inset),
            ratingLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: inset),
            
            votesCountLabel.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            votesCountLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 4),
            
            runtimeIcon.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            runtimeIcon.leadingAnchor.constraint(equalTo: votesCountLabel.trailingAnchor, constant: inset),
            
            runtimeLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: inset),
            runtimeLabel.leadingAnchor.constraint(equalTo: runtimeIcon.trailingAnchor, constant: 6)
        ])
    }
    
    // MARK: - Public methods
    
    /// Отображение постера фильма по вложенном `UIImageView`
    /// - Parameter image: `UIImage` постера
    func setPoster(_ image: UIImage) {
        posterView.image = image
    }
    
    /// Отображение модели представления в ячейке
    /// - Parameter movie: Модель фильма слоя представления
    func present(_ movie: MovieViewModel) {
        titleLabel.text = movie.title
        subtitleLabel.text = movie.subtitle
        genresLabel.text = movie.genres
        ratingLabel.text = movie.rating
        votesCountLabel.text = movie.voteCount
    }
    
    /// Очистка переиспользуемой ячейки
    func reset() {
        progress?.cancel()
        posterView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        genresLabel.text = nil
        ratingLabel.text = nil
        votesCountLabel.text = nil
    }
    
}
