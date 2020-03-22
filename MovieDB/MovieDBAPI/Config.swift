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
    
    /// ID текущей сессии
    public static var sessionId: String?
    
    /// Словарь параметров текущей сессии
    static var sessionParameters: [String: Any] {
        var parameters = ["api_key": apiKey]
        if let sessionId = sessionId {
            parameters["session_id"] = sessionId
        }
        return parameters
    }
    
    /// Возвращает объединённый словарь параметров запроса и сессии
    /// - Parameter parameters: Дополнительные параметры запроса
    static func sessionParameters(and parameters: [String: Any]) -> [String: Any] {
        sessionParameters.merging(parameters, uniquingKeysWith: { _, new in new })
    }
}
