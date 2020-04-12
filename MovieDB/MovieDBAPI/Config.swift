//
//  Config.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 22.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Конфиг сессии API themoviedb.org
public class Config {
    
    /// `URL` themoviedb.org API
    static let baseUrl = URL(string: "https://api.themoviedb.org/3")!
    
    /// API Key приложения
    static let apiKey = "078d0533a0b06401c117b0818a7b1e99"
    
    /// Базовый `URL` для получения изображений из themoviedb.org API
    public static var imagesBaseUrl = URL(string: "https://image.tmdb.org/t/p/w500")!
    
    /// ID текущей сессии
    public static var sessionId: String?
    
    /// ID авторизованного в данный момент пользователя
    public static var accountId: Int = 0
    
    /// ISO 639-1 код текущего языка приложения
    public static var language: String? {
        guard let languageCode = Locale.current.languageCode,
            let regionCode = Locale.current.regionCode
            else {
                return nil
        }
        return "\(languageCode)-\(regionCode)"
    }
    
    /// Словарь параметров текущей сессии
    static var sessionParameters: [String: Any] {
        var parameters = ["api_key": apiKey]
        if let sessionId = sessionId {
            parameters["session_id"] = sessionId
        }
        if let language = language {
            parameters["language"] = language
        }
        return parameters
    }
    
    /// Возвращает объединённый словарь параметров запроса и сессии
    /// - Parameter parameters: Дополнительные параметры запроса
    static func sessionParameters(and parameters: [String: Any]) -> [String: Any] {
        sessionParameters.merging(parameters, uniquingKeysWith: { _, new in new })
    }
}
