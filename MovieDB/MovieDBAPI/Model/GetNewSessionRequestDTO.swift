//
//  GetNewSessionRequestDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Структура тела запроса на получение Id сессии
public struct GetNewSessionRequestDTO: Encodable {
    
    /// Временный request token
    public let requestToken: String
    
    public init(requestToken: String) {
        self.requestToken = requestToken
    }

}
