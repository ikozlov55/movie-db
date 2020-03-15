//
//  GetNewSessionRequestDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public struct GetNewSessionRequestDTO: Encodable {
    public let requestToken: String
    
    public init(requestToken: String) {
        self.requestToken = requestToken
    }
}
