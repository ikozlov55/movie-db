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
    
    static let shared = AuthService()
    
    // MARK: - Private Properties
    
    private let decoder = JSONDecoder()
    private let baseUrl = URL(string: "https://api.themoviedb.org/3")!
    private let apiKey = "078d0533a0b06401c117b0818a7b1e99"
    private let apiClient: MovieDBClient
    
    // MARK: - Init
    
    init() {
        apiClient = MovieDBClient(baseUrl: baseUrl, apiKey: apiKey)
    }
    
    // MARK: - Public methods
    
    /// Авторизация в сервисе по имени пользователя и паролю
    /// - Parameters:
    ///   - username: Имя пользователя
    ///   - password: Пароль пользователя
    ///   - completion: Замыкание, на вход получает Result c sessionId или ошибку
    func login(
        username: String,
        password: String,
        completion: @escaping ((Result<String, Error>) -> Void)) {
        apiClient.request(GetNewTokenEndpoint()) { [weak self] result in
            switch result {
            case .success(let response):
                let validateToken = ValidateTokenEndpoint(
                    username: username,
                    password: password,
                    requestToken: response.requestToken
                )
                self?.apiClient.request(validateToken) { result in
                    switch result {
                    case .success(let response):
                        let getSessionId = GetNewSessionEndpoint(requestToken: response.requestToken)
                        self?.apiClient.request(getSessionId) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    let sessionId = response.sessionId
                                    self?.apiClient.sessionId = sessionId
                                    completion(.success(sessionId))
                                case .failure(let error):
                                    completion(.failure(error))
                                }
                            }
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
