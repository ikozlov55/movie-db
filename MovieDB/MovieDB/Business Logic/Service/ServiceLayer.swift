//
//  ServiceLayer.swift
//  MovieDB
//
//  Created by Илья Козлов on 22.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI

enum StatusCode: Int {
    case authenticationFailed = 3
    case invalidApiKey = 7
    case invalidCredentials = 30
}

/// Статический класс, содержащий все данные и сервисы для работы с API themoviedb.org
class ServiceLayer {
    
    /// `URL` themoviedb.org API
    static private let baseUrl = URL(string: "https://api.themoviedb.org/3")!
    
    /// API Key приложения
    static private let apiKey = "078d0533a0b06401c117b0818a7b1e99"
    
    /// `APIClient` для работы с API themoviedb.org
    static private let apiClient: APIClient = MovieDBClient(logger: PrintLogger())
    
    /// Сервис авторизации
    static let authService: AuthServiceProtocol = {
        AuthService(baseUrl: baseUrl, apiKey: apiKey, apiClient: apiClient)
    }()
}
