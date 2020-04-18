//
//  RealmManager.swift
//  MovieDBStorage
//
//  Created by Илья Козлов on 14.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import RealmSwift

/// Класс, отвечающий за обощённое низкоуровневое взаимодействие с Realm
final class RealmManager {
    
    // MARK: - Private Properties
    
    private let configuration: Realm.Configuration
    
    // MARK: - Init
    
    init(schemaVersion: UInt64 = 1, migrations: MigrationBlock? = nil) {
        configuration = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: migrations,
            deleteRealmIfMigrationNeeded: true
        )
    }
    
    // MARK: - Public Methods
    
    /// Чтение объектов указанного типа
    /// - Parameter type: Тип объектов, которые необходимо получить
    func read<T: Object>(_ type: T.Type) throws -> Results<T> {
        let realm = try Realm(configuration: configuration)
        return realm.objects(type)
    }
    
    /// Запись переданного списка объектов в Realm
    /// - Parameter objects: Массив объектов, которые необходиом записать
    func save<T: Object>(_ objects: [T]) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            realm.add(objects, update: .modified)
        }
    }
    
    /// Удаление из Realm переданного списка объектов
    /// - Parameter objects: Массив объектов, которые необходиом удалить
    func delete<T: Object>(_ objects: [T]) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            realm.delete(objects)
        }
    }
    
    /// Удаление из Realm всех объектов определённого типа
    /// - Parameter type: Тип объектов, которые необъодимо удалить
    func deleteAll<T: Object>(_ type: T.Type) throws {
        let objects = Array(try read(type))
        try delete(objects)
    }
    
}
