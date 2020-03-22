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
    
    private let baseUrl: URL
    private let apiKey: String
    
    public init(baseUrl: URL, apiKey: String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.plainRequest(
            baseUrl,
            path: "/authentication/token/new",
            parameters: ["api_key": apiKey]
        )
    }
}
