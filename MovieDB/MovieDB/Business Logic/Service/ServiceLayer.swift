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
    
    /// Сервис поиска фильмов
    static let searchService: MovieSearchServiceProtocol = {
        MovieSearchService(apiClient: apiClient)
    }()
    
    /// Сервис получения и обновлениеяданных аккаунта пользователя
    static let accountService: AccountServiceProtocol = {
        AccountService(apiClient: apiClient)
    }()
    
    /// Сервис загрузки изображений
    static let imagesService: ImagesServiceProtocol = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.urlCache = ImagesFileCache()
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let client = ImagesClient(configuration: configuration)
        
        return ImagesService(apiClient: client)
    }()
    
    /// Сервис сохранения даннных"
    static var storageService: StorageServiceProtocol = {
        StorageService(.coreData)
    }()
    
    /// Криптографический сервис
    static var cryptoService: CryptoServiceProtocol = {
        CryptoService()
    }()
    
    /// Сервис для работы с Keychain
    static var keychainService: KeyChainServiceProtocol = {
        KeyChainService()
    }()
    
    /// Сервис авторизации по пин-коду
    static var pinAuthorizationService: PinAuthorizationServiceProtocol = {
        PinAuthorizationService()
    }()
}
