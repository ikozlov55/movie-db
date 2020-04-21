//
//  AuthService.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI

/// Тип, отвечающий за авторизацию в themoviedb.org API
protocol AuthServiceProtocol {
    
    /// Авторизация в сервисе по имени пользователя и паролю
    /// - Parameters:
    ///   - username: Имя пользователя
    ///   - password: Пароль пользователя
    ///   - completion: Замыкание, на вход получает Result c sessionId или ошибкой
    func login(
        username: String,
        password: String,
        completion: @escaping ((Result<Bool, Error>) -> Void)
    )
}

final class AuthService: AuthServiceProtocol {
    
    // MARK: - Private Properties
    
    private let apiClient: APIClient
    
    // MARK: - Init
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func login(
        username: String,
        password: String,
        completion: @escaping ((Result<Bool, Error>) -> Void)) {
        apiClient.request(GetNewTokenEndpoint()) { [weak self] result in
            switch result {
            case .success(let response):
                let validateToken = ValidateTokenEndpoint(
                    body: ValidateTokenRequestDTO(
                        username: username,
                        password: password,
                        requestToken: response.requestToken
                    )
                )
                self?.apiClient.request(validateToken) { result in
                    switch result {
                    case .success(let response):
                        let getSessionId = GetNewSessionEndpoint(
                            body: GetNewSessionRequestDTO(requestToken: response.requestToken)
                        )
                        self?.apiClient.request(getSessionId) { result in
                            switch result {
                            case .success(let response):
                                Config.sessionId = response.sessionId
                                completion(.success(true))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
