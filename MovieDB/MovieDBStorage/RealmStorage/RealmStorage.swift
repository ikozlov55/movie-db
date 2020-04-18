//
//  RealmStorage.swift
//  MovieDBStorage
//
//  Created by Илья Козлов on 14.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import RealmSwift

/// Реализация `MovieDBStorage` работающая через Realm
public final class RealmStorage: MovieDBStorage {
    
    private let realmManager = RealmManager()
    
    public init() {}
    
    public func read() throws -> [DBMovie] {
        let objects = try realmManager.read(RLMMovie.self)
        return objects.map {
            var posterUrl: URL?
            if let posterAddress = $0.posterAddress {
                posterUrl = URL(string: posterAddress)
            }
            return DBMovie(
                id: $0.id,
                voteCount: $0.voteCount,
                voteAverage: $0.voteAverage,
                posterUrl: posterUrl,
                originalTitle: $0.originalTitle,
                genres: Array($0.genres),
                title: $0.title,
                overview: $0.overview,
                releaseDate: $0.releaseDate
            )
        }
    }
    
    public func save(_ movies: [DBMovie]) throws {
        try realmManager.deleteAll(RLMMovie.self)
        let objects = movies.map { (movie: DBMovie) -> RLMMovie in
            let object = RLMMovie()
            let genres = List<Int>()
            genres.append(objectsIn: movie.genres)
            object.id = movie.id
            object.voteCount = movie.voteCount
            object.voteAverage = movie.voteAverage
            object.posterAddress = movie.posterUrl?.absoluteString
            object.originalTitle = movie.originalTitle
            object.genres = genres
            object.title = movie.title
            object.overview = movie.overview
            object.releaseDate = movie.releaseDate
            
            return object
        }
        try realmManager.save(objects)
    }
    
}
