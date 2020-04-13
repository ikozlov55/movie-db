//
//  StorageService.swift
//  MovieDB
//
//  Created by Илья Козлов on 13.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import MovieDBStorage

/// Тип используемого хранилища
enum StorageType {
    case coreData
    case realm
}

/// Тип, ответсвенный за хранение данных в БД
protocol StorageServiceProtocol {
    
    /// Получение списка фильмов из БД
    func read() -> [Movie]
    
    /// Запись фильмов в БД
    /// - Parameter movies: Список фильмов, который необходимо сохранить
    func save(_ movies: [Movie])
}

final class StorageService: StorageServiceProtocol {
    
    private let storage: MovieDBStorage
    
    init(_ type: StorageType) {
        storage = CoreDataStorage()
    }
    
    func read() -> [Movie] {
        var result = [Movie]()
        do {
            let storageMovies = try storage.read()
            result = storageMovies.map { MoviesTransformer.movie(from: $0) }
        } catch {
            print("STORAGE READ FAIL!!! \(error)")
        }
        print("READ SUCCESS!!")
        result.forEach { movie in print(movie.title) }
        return result
    }
    
    func save(_ movies: [Movie]) {
        let storageMovies = movies.map { MoviesTransformer.storageObject(from: $0) }
        do {
            try storage.save(storageMovies)
        } catch {
            print("STORAGE SAVE FAIL!!! \(error)")
        }
        print("SAVE SUCCESS!!")
    }
    
}
