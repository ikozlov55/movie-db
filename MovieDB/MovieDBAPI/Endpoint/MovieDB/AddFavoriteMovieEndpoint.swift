//
//  AddFavoriteMovieEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final class AddFavoriteMovieEndpoint: JSONRequestEndpoint, JSONResponseEndpoint {
    typealias Content = MoviesListDTO
    
    let coder: Coder = MovieDBCoder()
    let body: AddFavoriteMovieRequestDTO
    let accountId: Int
    
    public init(accountId: Int, mediaType: String, mediaId: String, favorite: Bool) {
        self.accountId = accountId
        body = AddFavoriteMovieRequestDTO(
            mediaType: mediaType,
            mediaId: mediaId,
            favorite: favorite
        )
    }
    
    func makeRequest() throws -> URLRequest {
        var request = URLRequest(url: Account.addFavorite.accountId(accountId))
        request.setHttpMethod(.POST)
        request.httpBody = try encoder.encode(body)
        request.addContentType(.json)
        return request
    }
    
}
