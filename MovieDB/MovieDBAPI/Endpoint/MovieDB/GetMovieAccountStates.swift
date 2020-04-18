//
//  GetMovieAccountStates.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// `Endpoint` получения состояния фильма в контексте сессии пользователя
final public class GetMovieAccountStates: JSONEndpoint {
    public typealias Content = AccountStatesDTO
    
    private let movieId: Int
    
    public init(movieId: Int) {
        self.movieId = movieId
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.plainRequest(
            Config.baseUrl,
            path: "/movie/\(String(describing: movieId))/account_states",
            parameters: Config.sessionParameters
        )
    }
}
