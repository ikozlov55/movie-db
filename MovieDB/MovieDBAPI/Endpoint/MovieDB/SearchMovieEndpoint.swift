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
    
    private let baseUrl: URL
    private let apiKey: String
    private let language: String?
    
    public init(baseUrl: URL, apiKey: String, query: String, language: String? = nil) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.language = language
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.plainRequest(
            baseUrl,
            path: "/search/movie",
            parameters: ["api_key": apiKey, "language": language ?? ""]
        )
    }
}
