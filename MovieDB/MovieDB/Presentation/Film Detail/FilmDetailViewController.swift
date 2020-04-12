//
//  FilmDetailViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 11.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Тип, задача которого - отобразить подробную информацию о фильме на отдельном экране
protocol FilmDetailViewControllerProtocol: UIViewController {
    
    /// Отображение модели представления в модуле
    /// - Parameter movie: Модель фильма слоя представления
    func present(movie: MovieViewModel)
}

final class FilmDetailViewController: BaseViewController, FilmDetailViewControllerProtocol {
    
    // MARK: - Private Properties
    
    private var detailView = FilmDetailView()
    
    /// Прогресс загрузки изображения с постером фильма
    private var progress: Progress?
    
    private let imagesService = ServiceLayer.imagesService
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        progress?.cancel()
    }
    
    // MARK: - Public methods
    func present(movie: MovieViewModel) {
        detailView.titleLabel.text = movie.title
        detailView.subtitleLabel.text = movie.subtitle
        detailView.genresLabel.text = movie.genres
        detailView.ratingLabel.text = movie.rating
        detailView.votesCountLabel.text = movie.voteCount
        detailView.descriptionLabel.text = movie.overview
        
        detailView.runtimeLabel.text = "120 мин"
        guard let posterUtl = movie.posterUrl else { return }
        progress = imagesService.load(posterUtl) { [weak self] result in
            switch result {
            case .success(let image):
                self?.detailView.posterView.image = image
            case .failure:
                return
            }
        }
    }
}
