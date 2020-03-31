//
//  SearchMovieEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final public class SearchMovieEndpoint: JSONEndpoint {
    public typealias Content = MoviesListDTO
    
    private let query: String
    private let page: Int
    
    public init(query: String, page: Int = 1) {
        self.query = query
        self.page = page
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.plainRequest(
            Config.baseUrl,
            path: "/search/movie",
            parameters: Config.sessionParameters(and: [
                "query": query,
                "page": page
            ])
        )
    }
}
