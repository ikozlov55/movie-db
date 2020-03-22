//
//  GetNewSessionDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Структура ответа на запроса получения session ID
public struct GetNewSessionDTO: Decodable {
    
    /// Результат запроса
    public let success: Bool
    
    /// Session ID
    public let sessionId: String
    
}
