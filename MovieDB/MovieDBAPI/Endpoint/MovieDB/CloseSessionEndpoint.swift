//
//  CloseSessionEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final public class CloseSessionEndpoint: VoidResponseEndpoint {
    private let baseUrl: URL
    private let apiKey: String
    private let body: CloseSessionRequestDTO
    
    public init(baseUrl: URL, apiKey: String, body: CloseSessionRequestDTO) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.body = body
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.jsonBodyRequest(
            .DELETE,
            baseUrl,
            path: "/authentication/session",
            parameters: ["api_key": apiKey],
            body: body
        )
    }
    
}
