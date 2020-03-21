//
//  ValidateTokenRequestDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Объект тела запроса на валидацию request token
public struct ValidateTokenRequestDTO: Encodable {
    
    /// Имя пользоваетеля
    public let username: String
    
    /// Пароль
    public let password: String
    
    /// Временный request token
    public let requestToken: String
    
    public init(username: String, password: String, requestToken: String) {
        self.username = username
        self.password = password
        self.requestToken = requestToken
    }

}
