//
//  FavoritesTopBarViewController.swift
//  MovieDB
//
//  Created by Илья Козлов on 12.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `UIViewController` который выполняет поиск по  списку избранного авторизованного пользователя
/// и оповещает свой делегат о результатах
protocol FavoritesTopBarViewControllerProtocol: UIViewController {
    
    /// `FavoritesTopBarViewControllerDelegate` который оповещается о результатх поиска
    var delegate: FavoritesTopBarViewControllerDelegate? { get set }
    
    /// Поиск фильмов по списку избранного
    /// - Parameter query: Поисковый запрос
    func search(query: String, page: Int)
}

/// Тип, который обрабатывает результаты поиск фильмов
protocol FavoritesTopBarViewControllerDelegate: class {
    
    /// Обработка изменения типа расположения результатов поиска
    /// - Parameter layout: Тип расположения
    func resultsLayoutChanged(to layout: SearchResultsLayout)
    
    /// Обработка начала поиска
    func searchStarted()
    
    /// Обработка результатов поиска
    /// - Parameter result: Страница результатов поиска типа `MoviesList`
    func searchFinished(with result: MoviesList)
}

final class FavoritesTopBarViewController: BaseViewController, FavoritesTopBarViewControllerProtocol {

    // MARK: - Public Properties
    
    weak var delegate: FavoritesTopBarViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private var topBarView = FavoritesTopBarView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = topBarView
    }

    // MARK: - Public methods
    func search(query: String, page: Int) {}
    
}
