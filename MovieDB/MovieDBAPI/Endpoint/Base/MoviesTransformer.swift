//
//  MoviesTransformer.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI
import MovieDBStorage

/// Статический класс для преобразования моделей фильмов сетевого слоя в бизнес объекты
final class MoviesTransformer {
    
    // MARK: - Public methods
    
    /// Преобразование модели сетевого слоя `MovieDTO` в `Movie`
    /// - Parameter dto: модель `MovieDTO` сетевого слоя, которую необходимо преобразовать
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
    /// - Parameter dto: модель `MoviesListDTO` сетевого слоя, которую необходимо преобразовать
    static func moviesList(from dto: MoviesListDTO) -> MoviesList {
        MoviesList(
            page: dto.page,
            totalResults: dto.totalResults,
            totalPages: dto.totalPages,
            results: dto.results.map { movie(from: $0) }
        )
    }
    
    /// Преобразование модели слоя данных `StorageMovie` в `Movie`
    /// - Parameter storageObject: модель слоя данных, которую необходимо преобразовать
    static func movie(from storageObject: DBMovie) -> Movie {
        Movie(
            id: storageObject.id,
            voteCount: storageObject.voteCount,
            voteAverage: storageObject.voteAverage,
            posterUrl: storageObject.posterUrl,
            originalTitle: storageObject.originalTitle,
            genres: storageObject.genres,
            title: storageObject.title,
            overview: storageObject.overview,
            releaseDate: storageObject.releaseDate
        )
    }
    
    /// Преобразование бизнес объекта `Movie` в модель слоя данных
    /// - Parameter movie: бизнес объект, который необходимо преобразовать
    static func storageObject(from movie: Movie) -> DBMovie {
        DBMovie(
            id: movie.id,
            voteCount: movie.voteCount,
            voteAverage: movie.voteAverage,
            posterUrl: movie.posterUrl,
            originalTitle: movie.originalTitle,
            genres: movie.genres,
            title: movie.title,
            overview: movie.overview,
            releaseDate: movie.releaseDate
        )
    }
}
