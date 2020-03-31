//
//  MoviesTranformer.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI

/// Статический класс для преобразования моделей фильмов сетевого слоя в бизнес объекты
final class MoviesTranformer {
    
    // MARK: - Public methods
    
    /// Преобразование модели `MovieDTO` в `Movie`
    /// - Parameter dto: модель `MovieDTO` сетевого слоя
    static func movie(from dto: MovieDTO) -> Movie {
        var posterUrl: URL?
        if let posterPath = dto.posterPath {
            posterUrl = Config.imagesBaseUrl.appendingPathComponent(posterPath)
        }

        return Movie(
            id: dto.id,
            voteCount: dto.voteCount,
            voteAverage: dto.voteAverage,
            posterUrl: posterUrl,
            originalTitle: dto.originalTitle,
            genres: dto.genreIds,
            title: dto.title,
            overview: dto.overview,
            releaseDate: dto.releaseDate
        )
    }
    
    /// Преобразование модели `MoviesListDTO` в `MoviesList`
    /// - Parameter dto: модель `MoviesListDTO` сетевого слоя
    static func moviesList(from dto: MoviesListDTO) -> MoviesList {
        MoviesList(
            page: dto.page,
            totalResults: dto.totalResults,
            totalPages: dto.totalPages,
            results: dto.results.map { movie(from: $0) }
        )
    }
}
