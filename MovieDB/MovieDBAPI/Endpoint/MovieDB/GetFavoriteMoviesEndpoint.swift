//
//  GetFavoriteMoviesEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final public class GetFavoriteMoviesEndpoint: JSONEndpoint {
    public typealias Content = MoviesListDTO
    
    private let baseUrl: URL
    private let apiKey: String
    private let sessionId: String
    private let accountId: Int
    
    public init(baseUrl: URL, apiKey: String, sessionId: String, accountId: Int) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.sessionId = sessionId
        self.accountId = accountId
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.plainRequest(
            baseUrl,
            path: "account/\(accountId)/favorite/movies",
            parameters: ["api_key": apiKey, "session_id": sessionId]
        )
    }
}
