//
//  GetGenresEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// `Endpoint` получения словаря жанров 
final public class GetGenresEndpoint: JSONEndpoint {
    public typealias Content = GenresListDTO
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.plainRequest(
            Config.baseUrl,
            path: "/genre/movie/list",
            parameters: Config.sessionParameters
        )
    }
}
