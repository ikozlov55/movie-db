//
//  AccountService.swift
//  MovieDB
//
//  Created by Илья Козлов on 12.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI

/// Тип, отвечающий за получение и обновление данных аккаунта пользователя
protocol AccountServiceProtocol {
    
    /// Получение данных аккаунта и запись id пользователя в `Config` сессии
    /// - Parameter completion: Замыкание, на вход получает список `GetAccountDTO` или ошибку
    func getAccountData(completion: ((Result<GetAccountDTO, Error>) -> Void)?)
    
    /// Получение списка избранного
    /// - Parameter completion: Замыкание, на вход получает список `MoviesList` или ошибку
    func getFavorites(completion: @escaping ((Result<MoviesList, Error>) -> Void))
    
    /// Добавление в избранное
    /// - Parameters:
    ///   - mediaId: Id сущности, которую необходимо добавить в избранное
    ///   - completion: Замыкание, на вход получает true в случае успеха или ошибку
    func addToFavorites(mediaId: Int, completion: @escaping ((Result<Bool, Error>) -> Void))
    
    /// Удаление из избранного
    /// - Parameters:
    ///   - mediaId: Id сущности, которую необходимо удалить из избранного
    ///   - completion: Замыкание, на вход получает true в случае успеха или ошибку
    func removeFromFavorites(mediaId: Int, completion: @escaping ((Result<Bool, Error>) -> Void))
}

final class AccountService: AccountServiceProtocol {
    
    // MARK: - Private Properties
    
    private let apiClient: APIClient
    
    // MARK: - Init
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func getAccountData(completion: ((Result<GetAccountDTO, Error>) -> Void)? = nil) {
        apiClient.request(GetAccountEndpoint()) { result in
            switch result {
            case .success(let accountInfo):
                completion?(.success(accountInfo))
                Config.accountId = accountInfo.id
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func getFavorites(completion: @escaping ((Result<MoviesList, Error>) -> Void)) {
        apiClient.request(GetFavoriteMoviesEndpoint()) { result in
            switch result {
            case .success(let result):
                completion(.success(MoviesTransformer.moviesList(from: result)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addToFavorites(mediaId: Int, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        postAccountFavorite(mediaId: mediaId, favorite: true, completion: completion)
    }
    
    func removeFromFavorites(mediaId: Int, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        postAccountFavorite(mediaId: mediaId, favorite: false, completion: completion)
    }
    
    // MARK: - Private Methods
    
    private func postAccountFavorite(
        mediaId: Int,
        favorite: Bool,
        completion: @escaping ((Result<Bool, Error>) -> Void)) {
        let endpoint = AddFavoriteMovieEndpoint(
            body: AddFavoriteMovieRequestDTO(
                mediaType: "movie",
                mediaId: mediaId,
                favorite: favorite
            )
        )
        apiClient.request(endpoint) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
