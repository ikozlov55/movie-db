//
//  Coder.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Структура со статическими атрибутами для кодирование и декодирования ответов API themoviedb.org
struct MovieDBCoder {
    
    /// Стандартный `JSONDecoder` ответов API themoviedb.org
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        return decoder
    }()
    
    /// Стандартный `JSONEncoder` запросов к API themoviedb.org
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

}
