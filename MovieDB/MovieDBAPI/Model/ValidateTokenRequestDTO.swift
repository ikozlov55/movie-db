//
//  ValidateTokenRequestDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public struct ValidateTokenRequestDTO: Encodable {
    public let username: String
    public let password: String
    public let requestToken: String
    
    public init(username: String, password: String, requestToken: String) {
        self.username = username
        self.password = password
        self.requestToken = requestToken
    }
}
