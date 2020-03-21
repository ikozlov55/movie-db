//
//  Coder.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Тип, который содержит атрибуты для кодирования и декодирования JSON тел HTTP запросов и ответов
protocol Coder {
    
    /// Декодер JSON тела HTTP ответа в модель
    var decoder: JSONDecoder { get }
    
    /// Кодер модели в JSON тело HTTP запроса
    var encoder: JSONEncoder { get }
}

/// `Coder` для запросов и ответо API themoviedb.org
struct MovieDBCoder: Coder {
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        return decoder
    }()
    
    let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
}
