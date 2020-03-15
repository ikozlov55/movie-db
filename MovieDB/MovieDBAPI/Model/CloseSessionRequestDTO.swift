//
//  CloseSessionRequestDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public struct CloseSessionRequestDTO: Encodable {
    public let sessionId: String
    
    public init(sessionId: String) {
        self.sessionId = sessionId
    }
}
