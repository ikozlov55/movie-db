//
//  GetAccountEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// `Endpoint` получения данных аккаунта пользователя
final public class GetAccountEndpoint: JSONEndpoint {
    public typealias Content = GetAccountDTO
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.plainRequest(
            Config.baseUrl,
            path: "/account",
            parameters: Config.sessionParameters
        )
    }
    
}
