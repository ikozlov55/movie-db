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
    
    /// Название файла с постером
    let posterUrl: URL?
    
    /// Оригинальное название
    let originalTitle: String
    
    /// Жанры фильма в виде строки с разделителем в виде запятой
    let genres: String
    
    /// Локализованное название
    let title: String
    
    /// Описание
    let overview: String
    
    /// Год выхода
    let releaseYear: Int?
    
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
