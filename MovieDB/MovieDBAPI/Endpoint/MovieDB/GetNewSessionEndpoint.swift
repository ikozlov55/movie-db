//
//  GetNewSessionEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final public class GetNewSessionEndpoint: JSONEndpoint {
    public typealias Content = GetNewSessionDTO
    
    private let baseUrl: URL
    private let apiKey: String
    private let body: GetNewSessionRequestDTO
    
    public init(baseUrl: URL, apiKey: String, body: GetNewSessionRequestDTO) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.body = body
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.jsonBodyRequest(
            .POST,
            baseUrl,
            path: "/authentication/session/new",
            parameters: ["api_key": apiKey],
            body: body
        )
    }
    
}
