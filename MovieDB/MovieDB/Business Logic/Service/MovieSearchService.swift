//
//  MovieSearchService.swift
//  MovieDB
//
//  Created by Илья Козлов on 28.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI

/// Тип, отвечающий за поиск фильмов в themoviedb.org API
protocol MovieSearchServiceProtocol {
    
    /// Поиск фильмов
    /// - Parameters:
    ///   - query: Поисковый запрос
    ///   - completion: Замыкание, на вход получает список `MoviesList` или ошибку
    func search(
        query: String,
        page: Int,
        completion: @escaping ((Result<MoviesList, Error>) -> Void)
    )
    
    /// Получение и сохранение словаря жанров
    /// - Parameter completion: Замыкание, на вход получает список `GenresListDTO` или ошибку
    func getGenres(completion: ((Result<Bool, Error>) -> Void)?)
}

final class MovieSearchService: MovieSearchServiceProtocol {
    
    // MARK: - Private Properties
    
    private let apiClient: APIClient
    
    // MARK: - Init
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func search(
        query: String,
        page: Int = 1,
        completion: @escaping ((Result<MoviesList, Error>) -> Void)) {
        apiClient.request(SearchMovieEndpoint(query: query, page: page)) { result in
            switch result {
            case .success(let result):
                completion(.success(MoviesTransformer.moviesList(from: result)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getGenres(completion: ((Result<Bool, Error>) -> Void)? = nil) {
        guard GenresDict.genres.isEmpty else { return }
        apiClient.request(GetGenresEndpoint()) { result in
            switch result {
            case .success(let genresList):
                GenresDict.genres = genresList.genres
                completion?(.success(true))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
