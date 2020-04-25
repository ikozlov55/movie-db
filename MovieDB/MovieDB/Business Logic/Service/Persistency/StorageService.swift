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
    
    /// Тип БД: Cored Data  или Realm
    var storageType: StorageType { get set }
}

final class StorageService: StorageServiceProtocol {
    
    private var storage: MovieDBStorage
    
    var storageType: StorageType {
        didSet {
            storage = buildStorage(storageType)
        }
    }
    
    init(_ storageType: StorageType) {
        self.storageType = storageType
        switch storageType {
        case .coreData:
            storage = CoreDataStorage()
        case .realm:
            storage = RealmStorage()
        }
    }
    
    func read() -> [Movie] {
        var result: [Movie]
        do {
            let storageMovies = try storage.read()
            result = storageMovies.map { MoviesTransformer.movie(from: $0) }
        } catch {
            result = []
        }
        return result
    }
    
    func save(_ movies: [Movie]) {
        let storageMovies = movies.map { MoviesTransformer.storageObject(from: $0) }
        do {
            try storage.save(storageMovies)
        } catch {
            return
        }
    }
    
    private func buildStorage(_ type: StorageType) -> MovieDBStorage {
        switch storageType {
        case .coreData:
            return CoreDataStorage()
        case .realm:
            return RealmStorage()
        }
    }
    
}
