//
//  MoviesList.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Структура с информацией о фильме или сериале
struct Movie {
    
    /// Id сущности
    let id: Int
    
    /// Количество голосов/лайков
    let voteCount: Int
    
    /// Рейтинг фильма от 0 до 10
    let voteAverage: Double
    
    /// Адрес файла с постером
    let posterUrl: URL?
    
    /// Оригинальное название
    let originalTitle: String
    
    /// Id жанров фильма
    let genres: [Int]
    
    /// Локализованное название
    let title: String
    
    /// Описание
    let overview: String
    
    /// Дата выхода
    let releaseDate: Date?
    
}

/// Структура страницы списка фильмов или сериалов - результат поиска или список избранного
struct MoviesList {
    
    /// Номер страницы
    public let page: Int
    
    /// Общее количество элементов  во всех страницах списка
    public let totalResults: Int
    
    /// Общее количество страниц
    public let totalPages: Int
    
    /// Элементы текущей страницы
    public let results: [Movie]

}
