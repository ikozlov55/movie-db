//
//  GetNewTokenDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public struct GetNewTokenDTO: Decodable {
    public let success: Bool
    public let expiresAt: Date
    public let requestToken: String
    
    public init(success: Bool, expiresAt: Date, requestToken: String) {
        self.success = success
        self.expiresAt = expiresAt
        self.requestToken = requestToken
    }
}
