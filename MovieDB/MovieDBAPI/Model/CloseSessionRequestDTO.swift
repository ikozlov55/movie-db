//
//  CloseSessionRequestDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Структура тела запроса на завершение сессии
public struct CloseSessionRequestDTO: Encodable {
    
    /// Id сессии
    public let sessionId: String
    
    public init(sessionId: String) {
        self.sessionId = sessionId
    }

}
