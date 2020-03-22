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
    
    private let accountId: Int
    private let body: AddFavoriteMovieRequestDTO
    
    public init(accountId: Int, body: AddFavoriteMovieRequestDTO) {
        self.accountId = accountId
        self.body = body
    }
    
    func makeRequest() throws -> URLRequest {
        try URLRequest.jsonBodyRequest(
            .POST,
            Config.baseUrl,
            path: "account/\(accountId)/favorite",
            parameters: Config.sessionParameters,
            body: body
        )
    }
}
