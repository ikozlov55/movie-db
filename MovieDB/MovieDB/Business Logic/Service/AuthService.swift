//
//  AuthService.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI

protocol AuthServiceProtocol {
    func login(
        username: String,
        password: String,
        completion: @escaping ((Result<String, Error>) -> Void)
    )
}

final class AuthService: AuthServiceProtocol {
    
    // MARK: - Private Properties
    
    private let baseUrl: URL
    private let apiKey: String
    private let apiClient: APIClient
    
    // MARK: - Init
    
    init(baseUrl: URL, apiKey: String, apiClient: APIClient) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    /// Авторизация в сервисе по имени пользователя и паролю
    /// - Parameters:
    ///   - username: Имя пользователя
    ///   - password: Пароль пользователя
    ///   - completion: Замыкание, на вход получает Result c sessionId или ошибкой
    func login(
        username: String,
        password: String,
        completion: @escaping ((Result<String, Error>) -> Void)) {
        let getToken = GetNewTokenEndpoint(baseUrl: baseUrl, apiKey: apiKey)
        apiClient.request(getToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let validateToken = ValidateTokenEndpoint(
                    baseUrl: self.baseUrl,
                    apiKey: self.apiKey,
                    body: ValidateTokenRequestDTO(
                        username: username,
                        password: password,
                        requestToken: response.requestToken
                    )
                )
                self.apiClient.request(validateToken) { result in
                    switch result {
                    case .success(let response):
                        let getSessionId = GetNewSessionEndpoint(
                            baseUrl: self.baseUrl,
                            apiKey: self.apiKey,
                            body: GetNewSessionRequestDTO(requestToken: response.requestToken)
                        )
                        self.apiClient.request(getSessionId) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    let sessionId = response.sessionId
                                    completion(.success(sessionId))
                                case .failure(let error):
                                    completion(.failure(error))
                                }
                            }
                        }
                    case .failure(let error):
                        self.finish(with: error, handler: completion)
                    }
                }
            case .failure(let error):
                self.finish(with: error, handler: completion)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func finish(
        with error: Error,
        handler: @escaping ((Result<String, Error>) -> Void)
    ) {
        DispatchQueue.main.async {
            handler(.failure(error))
        }
    }
    
}
