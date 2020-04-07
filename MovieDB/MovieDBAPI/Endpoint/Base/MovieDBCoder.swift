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
    
    /// Возможные форматы дат ответов themoviedb.org API
    static let allowedDateFormats = [
        "yyyy-MM-dd HH:mm:ss zzz",
        "yyyy-MM-dd",
        ""
    ]
    
    /// Стандартный `JSONDecoder` ответов API themoviedb.org
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let formatter = DateFormatter()
        decoder.dateDecodingStrategy = .custom({ decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            for format in allowedDateFormats {
                formatter.dateFormat = format
                if let date = formatter.date(from: dateString) {
                    return date
                }
            }
            
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode date string \(dateString)"
            )
        })
        
        return decoder
    }()
    
    /// Стандартный `JSONEncoder` запросов к API themoviedb.org
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
}
