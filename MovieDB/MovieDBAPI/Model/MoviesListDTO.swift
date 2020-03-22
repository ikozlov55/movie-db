//
//  MoviesListDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Структура с информацией о фильме или сериале
public struct MovieDTO: Decodable {
    
    /// Id сущности
    public let id: Int
    
    /// Количество голосов/лайков
    public let voteCount: Int
    
    /// Рейтинг фильма от 0 до 10
    public let voteAverage: Double
    
    /// Название файла с постером
    public let posterPath: String
    
    /// Название файла с задником
    public let backdropPath: String
    
    /// Оригинальное название
    public let originalTitle: String
    
    /// Список id жанров
    public let genreIds: [Int]
    
    /// Локализованное название
    public let title: String
    
    /// Описание
    public let overview: String
}

/// Структура страницы списка фильмов или сериалов - результат поиска или список избранного
public struct MoviesListDTO: Decodable {
    
    /// Номер страницы
    public let page: Int
    
    /// Общее количество элементов  во всех страницах списка
    public let totalResults: Int
    
    /// Общее количество страниц
    public let totalPages: Int
    
    /// Элементы текущей страницы
    public let results: [MovieDTO]
}
