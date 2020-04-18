//
//  StorageMovie.swift
//  MovieDBStorage
//
//  Created by Илья Козлов on 13.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Структура с информацией о фильме или сериале слоя данных
public struct DBMovie {
    
    /// Id сущности
    public let id: Int
    
    /// Количество голосов/лайков
    public let voteCount: Int
    
    /// Рейтинг фильма от 0 до 10
    public let voteAverage: Double
    
    /// Адрес файла с постером
    public let posterUrl: URL?
    
    /// Оригинальное название
    public let originalTitle: String
    
    /// Id жанров фильма
    public let genres: [Int]
    
    /// Локализованное название
    public let title: String
    
    /// Описание
    public let overview: String
    
    /// Дата выхода
    public let releaseDate: Date?
    
    public init(
        id: Int,
        voteCount: Int,
        voteAverage: Double,
        posterUrl: URL?,
        originalTitle: String,
        genres: [Int],
        title: String,
        overview: String,
        releaseDate: Date?) {
        self.id = id
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.posterUrl = posterUrl
        self.originalTitle = originalTitle
        self.genres = genres
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
}
