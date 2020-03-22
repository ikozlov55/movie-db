//
//  ServiceLayer.swift
//  MovieDB
//
//  Created by Илья Козлов on 22.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI

/// Коды ошибок от API themoviedb.org
enum StatusCode: Int {
    case authenticationFailed = 3
    case invalidApiKey = 7
    case invalidCredentials = 30
}

/// Статический класс, содержащий все данные и сервисы для работы с API themoviedb.org
class ServiceLayer {
    
    /// `APIClient` для работы с API themoviedb.org
    static private let apiClient: APIClient = MovieDBClient(logger: PrintLogger())
    
    /// Сервис авторизации
    static let authService: AuthServiceProtocol = {
        AuthService(apiClient: apiClient)
    }()
    
}
