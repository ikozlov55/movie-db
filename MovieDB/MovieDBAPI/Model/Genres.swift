//
//  Genres.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI

/// Словарь жанров, получаемы из themoviedb.org API
final class GenresDict {
    
    /// Список моделей жанров
    static var genres: [GenreDTO] = []
    
    /// Получение готовой для отображения строки со списком жанров из словаря
    /// - Parameter genreIds: Список id жанров
    static func stringFrom(_ genreIds: [Int]) -> String {
        genres.filter { genreIds.contains($0.id) }.map { $0.name }.joined(separator: ", ")
    }
}
