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
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.plainRequest(
            Config.baseUrl,
            path: "account/\(String(describing: Config.accountId))/favorite/movies",
            parameters: Config.sessionParameters
        )
    }
}
