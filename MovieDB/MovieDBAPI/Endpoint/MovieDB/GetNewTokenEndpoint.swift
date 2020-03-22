//
//  GetNewTokenEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final public class GetNewTokenEndpoint: JSONEndpoint {
    public typealias Content = GetNewTokenDTO
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.plainRequest(
            Config.baseUrl,
            path: "/authentication/token/new",
            parameters: Config.sessionParameters
        )
    }
}
