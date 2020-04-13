//
//  MovieDBStorage.swift
//  MovieDBStorage
//
//  Created by Илья Козлов on 13.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Тип, отвечающий за запись и чтение фильмов из БД
public protocol MovieDBStorage {
    
    /// Получение списка сохранённых фильмов из хранилища
    func read() throws -> [StorageMovie]
    
    /// Запись списка фильмов в хранилище
    /// - Parameter movies: Список фильмов, который необходимо сохранить
    func save(_ movies: [StorageMovie]) throws
}
