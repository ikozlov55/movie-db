//
//  GetNewSessionDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public struct GetNewSessionDTO: Decodable {
    public let success: Bool
    public let sessionId: String
    
    public init(success: Bool, sessionId: String) {
        self.success = success
        self.sessionId = sessionId
    }
}
