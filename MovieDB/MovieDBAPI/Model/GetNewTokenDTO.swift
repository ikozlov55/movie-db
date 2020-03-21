//
//  GetNewTokenDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Объект ответа на запрос получения request token
public struct GetNewTokenDTO: Decodable {
    
    /// Результат запроса
    public let success: Bool
    
    /// Дата истечения действия токена вида 2020-03-21 08:12:09 UTC
    public let expiresAt: Date
    
    /// Токен
    public let requestToken: String

}
