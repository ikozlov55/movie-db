//
//  Account.swift
//  MovieDB
//
//  Created by Илья Козлов on 21.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI

/// Структура с данными профиля пользователя
struct Account {
    /// Id пользователя
    public let id: Int
    
    /// Полное имя пользователя
    public let name: String
    
    /// Имя пользователя - логин
    public let username: String
    
    /// Хэш аватара пользователя в системе Gravatar?
    public let gravatarHash: String
    
    /// Статическая функция для создания структуры `Account` из структуры сетевого слоя `GetAccountDTO`
    /// - Parameter dto: структура сетевого слоя
    static func from(dto: GetAccountDTO) -> Account {
        Account(
            id: dto.id,
            name: dto.name,
            username: dto.username,
            gravatarHash: dto.avatar.gravatar.hash
        )
    }
}
