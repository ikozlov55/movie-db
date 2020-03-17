//
//  MoviesListDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 17.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public struct MovieDTO: Decodable {
    public let id: Int
    public let popularity: Double
    public let voteCount: Int
    public let voteAverage: Double
    public let posterPath: String
    public let backdropPath: String
    public let originalTitle: String
    public let genreIds: [Int]
    public let title: String
    public let overview: String
    
    public init(
        id: Int,
        popularity: Double,
        voteCount: Int,
        voteAverage: Double,
        posterPath: String,
        backdropPath: String,
        originalTitle: String,
        genreIds: [Int],
        title: String,
        overview: String
    ) {
        self.id = id
        self.popularity = popularity
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.originalTitle = originalTitle
        self.genreIds = genreIds
        self.title = title
        self.overview = overview
    }
}

public struct MoviesListDTO: Decodable {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [MovieDTO]
    
    public init(page: Int, totalResults: Int, totalPages: Int, results: [MovieDTO]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
}
