//
//  Genres.swift
//  MovieDB
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBAPI

final class GenresDict {
    static var genres: [GenreDTO] = []
    
    static func stringFrom(_ genreIds: [Int]) -> String {
        genres.filter { genreIds.contains($0.id) }.map { $0.name }.joined(separator: ", ")
    }
}
