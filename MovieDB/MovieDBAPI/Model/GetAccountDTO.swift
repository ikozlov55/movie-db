//
//  GetAccountDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Объект с данными пользователя в сервисе gravatar
public struct Gravatar: Decodable {
    
    /// Хэш аватара пользователя
    public let hash: String
    
}

/// Объект с данными аватара пользователя
public struct Avatatar: Decodable {
    
    /// Данными пользователя в сервисе gravatar
    public let gravatar: Gravatar
    
}

/// Объект ответа на запрос получения информации об аккаунте
public struct GetAccountDTO: Decodable {
    
    /// Аватара пользователя
    public let avatar: Avatatar
    
    /// Id пользователя
    public let id: Int
    
    /// Полное имя пользователя
    public let name: String
    
    /// Имя пользователя - логин
    public let username: String
    
}
