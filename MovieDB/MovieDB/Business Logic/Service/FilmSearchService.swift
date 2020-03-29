//
//  FilmSearchService.swift
//  MovieDB
//
//  Created by Илья Козлов on 28.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI

protocol FilmSearchServiceProtocol {
    func search(
        query: String,
        completion: @escaping ((Result<[MovieDTO], Error>) -> Void)
    )
}

/// Сервис поиска фильмов в themoviedb.org API
final class FilmSearchService: FilmSearchServiceProtocol {

    // MARK: - Private Properties
    
    private let apiClient: APIClient
    
    // MARK: - Init
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    /// Поиск фильмов
    /// - Parameters:
    ///   - query: Поисковый запрос
    ///   - completion: Замыкание, на вход получает список `MovieDTO` или ошибку
    func search(
        query: String,
        completion: @escaping ((Result<[MovieDTO], Error>) -> Void)) {
        apiClient.request(SearchMovieEndpoint(query: query)) { result in
            switch result {
            case .success(let moviesList):
                completion(.success(moviesList.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
