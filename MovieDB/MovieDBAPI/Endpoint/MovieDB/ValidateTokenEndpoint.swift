//
//  ValidateTokenEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final public class ValidateTokenEndpoint: JSONEndpoint {
    public typealias Content = GetNewTokenDTO
    
    private let baseUrl: URL
    private let apiKey: String
    private let body: ValidateTokenRequestDTO
    
    public init(baseUrl: URL, apiKey: String, body: ValidateTokenRequestDTO) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.body = body
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.jsonBodyRequest(
            .POST,
            baseUrl,
            path: "/authentication/token/validate_with_login",
            parameters: ["api_key": apiKey],
            body: body
        )
    }
}
