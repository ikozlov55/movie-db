//
//  GetFavoriteMoviesEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final public class GetFavoriteMoviesEndpoint: JSONResponseEndpoint {
    public typealias Content = MoviesListDTO
    
    let coder: Coder = MovieDBCoder()
    private let accountId: Int
    
    public init(accountId: Int) {
        self.accountId = accountId
    }
    
    public func makeRequest() throws -> URLRequest {
        URLRequest(url: Account.getFavoriteMovies.accountId(accountId))
    }
}
