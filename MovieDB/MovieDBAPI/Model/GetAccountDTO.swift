//
//  GetAccountDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public struct GetAccountDTO: Decodable {
    public let id: Int
    public let name: String
    public let username: String
    
    public init(id: Int, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
}
