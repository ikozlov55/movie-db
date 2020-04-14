//
//  RLMMovie.swift
//  MovieDBStorage
//
//  Created by Илья Козлов on 14.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import RealmSwift

final class RLMMovie: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var posterAddress: String?
    @objc dynamic var originalTitle: String = ""
    var genres = List<Int>()
    @objc dynamic var title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: Date?
    
    override static func primaryKey() -> String? {
        "id"
    }
}
