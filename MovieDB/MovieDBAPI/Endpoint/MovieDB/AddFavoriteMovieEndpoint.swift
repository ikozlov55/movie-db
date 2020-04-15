//
//  AddFavoriteMovieEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// `Endpoint` добавления фильма в список избранного
final public class AddFavoriteMovieEndpoint: JSONEndpoint {
    public typealias Content = RequestStatusDTO
    
    private let body: AddFavoriteMovieRequestDTO
    
    public init(body: AddFavoriteMovieRequestDTO) {
        self.body = body
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.jsonBodyRequest(
            .POST,
            Config.baseUrl,
            path: "account/\(String(describing: Config.accountId))/favorite",
            parameters: Config.sessionParameters,
            body: body
        )
    }
}
