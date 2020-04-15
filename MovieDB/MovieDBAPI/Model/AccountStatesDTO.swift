//
//  AccountStatesDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Структура, описывающая состояние фильма в контексте сессии пользователя
public struct AccountStatesDTO: Decodable {
    
    /// Id сущности
    public let id: Int
    
    /// Признак - находится ли фильм в списке избранного
    public let favorite: Bool
    
    /// Признак - поставил ли пользователь оценку данному фильму
    public let rated: Bool
    
    /// Признак - находится ли фильм в списке воспроизведения пользователя
    public let watchlist: Bool
    
}
