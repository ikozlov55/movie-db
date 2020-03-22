//
//  AddFavoriteMovieEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final class AddFavoriteMovieEndpoint: JSONEndpoint {
    typealias Content = MoviesListDTO
    
    private let baseUrl: URL
    private let apiKey: String
    private let sessionId: String
    private let accountId: Int
    private let body: AddFavoriteMovieRequestDTO
    
    public init(
        baseUrl: URL,
        apiKey: String,
        sessionId: String,
        accountId: Int,
        body: AddFavoriteMovieRequestDTO
    ) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.sessionId = sessionId
        self.accountId = accountId
        self.body = body
    }
    
    func makeRequest() throws -> URLRequest {
        try URLRequest.jsonBodyRequest(
            .POST,
            baseUrl,
            path: "account/\(accountId)/favorite",
            parameters: ["api_key": apiKey, "session_id": sessionId],
            body: body
        )
    }
}
