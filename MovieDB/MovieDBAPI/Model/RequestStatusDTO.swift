//
//  RequestStatusDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 21.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Структура ответа с данными ошибки
public struct RequestStatusDTO: Decodable, Error {
    
    /// Код ошибки
    public let statusCode: Int
    
    /// Сообщение
    public let statusMessage: String

}
