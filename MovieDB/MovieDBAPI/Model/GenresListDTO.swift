//
//  GenresListDTO.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 29.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Структура, описывающая жанр произведения
public struct GenreDTO: Decodable {
    
    /// Id сущности
    public let id: Int
    
    /// Имя жанра
    public let name: String
    
}

/// Структупа тела ответа на запрос получения словаря жанров
public struct GenresListDTO: Decodable {
    public let genres: [GenreDTO]
}
