//
//  SearchMovieEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final public class SearchMovieEndpoint: JSONResponseEndpoint {
    public typealias Content = MoviesListDTO
    
    internal let coder: Coder = MovieDBCoder()
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        URLRequest(url: Search.movie.url)
    }
}
