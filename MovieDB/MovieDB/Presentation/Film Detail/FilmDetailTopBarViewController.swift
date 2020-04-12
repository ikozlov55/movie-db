//
//  FilmDetailTopBarViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 12.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// Тип, ответственный за взаимодействие с экраном подробной информации о фильме
protocol FilmDetailTopBarViewControllerProtocol: UIViewController {
    
    /// `FilmDetailTopBarViewControllerDelegate` который обрабатывает взаимодействие с модулем
    var delegate: FilmDetailTopBarViewControllerDelegate? { get set }
    
    ///Изменить иконку надичия фильма в списке избранного - в списке/не в списке
    func toogleFavoriteIcon()
}

/// Тип, ответсвенный за обработку взаимодействия с экраном подробной информации о фильме
protocol FilmDetailTopBarViewControllerDelegate: class {
    
    /// Нажатие стрелочки навигации - назад
    func arrowBackTapped()
    
    /// Нажатие на иконку с сердечком
    func favoriteIconTapped()
}

final class FilmDetailTopBarViewController: BaseViewController, FilmDetailTopBarViewControllerProtocol {
    
    // MARK: - Public Properties
    
    weak var delegate: FilmDetailTopBarViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private var topBarView = FilmDetailTopBarView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = topBarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
    }
    
    // MARK: - Public methods
    
    func toogleFavoriteIcon() {
        topBarView.favoriteIcon.isFavorite.toggle()
    }
    
    // MARK: - Private Methods
    
    private func setupGestures() {
        let arrowBackTap = UITapGestureRecognizer(target: self, action: #selector(arrowBackTapped))
        topBarView.backArrow.addGestureRecognizer(arrowBackTap)
        let favoriteIconTap = UITapGestureRecognizer(target: self, action: #selector(favoriteIconTapped))
        topBarView.favoriteIcon.addGestureRecognizer(favoriteIconTap)
    }
    
    @objc private func arrowBackTapped() {
        delegate?.arrowBackTapped()
    }
    
    @objc private func favoriteIconTapped() {
        delegate?.favoriteIconTapped()
    }
}
