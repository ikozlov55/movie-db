//
//  AddFavoriteMovieRequestDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Структура тела запроса на добавление или удаление фильма или сериала в избранное
public struct AddFavoriteMovieRequestDTO: Encodable {
    
    /// Тип добавляемой сущности: movie или tv
    public let mediaType: String
    
    /// Id добавляемой сущности
    public let mediaId: Int
    
    /// Признак - добавить или удалить сущность
    public let favorite: Bool
    
    public init(mediaType: String, mediaId: Int, favorite: Bool) {
        self.mediaType = mediaType
        self.mediaId = mediaId
        self.favorite = favorite
    }

}
