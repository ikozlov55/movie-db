//
//  GetFavoriteMoviesEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// `Endpoint` получения списка избранных фильмов пользователя
final public class GetFavoriteMoviesEndpoint: JSONEndpoint {
    public typealias Content = MoviesListDTO
    
    private let accountId: Int
    
    public init(accountId: Int) {
        self.accountId = accountId
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.plainRequest(
            Config.baseUrl,
            path: "account/\(accountId)/favorite/movies",
            parameters: Config.sessionParameters
        )
    }
}
