//
//  AddFavoriteMovieRequestDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public struct AddFavoriteMovieRequestDTO: Encodable {
    public let mediaType: String
    public let mediaId: String
    public let favorite: Bool
    
    public init(mediaType: String, mediaId: String, favorite: Bool) {
        self.mediaType = mediaType
        self.mediaId = mediaId
        self.favorite = favorite
    }
}
