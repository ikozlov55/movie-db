//
//  KeyChainService.swift
//  MovieDB
//
//  Created by Илья Козлов on 19.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import KeychainAccess

/// Тип, отвечающий за запись, чтение и удаление данных из Keychain
protocol KeyChainServiceProtocol {
    
    /// Сохранение массив байт в Keychain
    /// - Parameters:
    ///   - bytes: Массив байт, который необходимо сохранить
    ///   - key: Ключ, по которому происходит запись
    func save(_ bytes: [UInt8], key: String)
    
    /// Сохранение строки в Keychain
    /// - Parameters:
    ///   - value: Строка, которую необходимо сохранить
    ///   - key: Ключ, по которому происходит запись
    func save(_ value: String, key: String)
    
    /// Сохранение целого числа в Keychain
    /// - Parameters:
    ///   - value: Число, которое необходимо сохранить
    ///   - key: Ключ, по которому происходит запись
    func save(_ value: Int, key: String)
    
    /// Чтение массива байт из Keychain
    /// - Parameter key: Ключ, по которому происходит чтение
    func getBytes(key: String) -> [UInt8]?
    
    /// Чтение строки из Keychain
    /// - Parameter key: Ключ, по которому происходит чтение
    func getString(key: String) -> String?
    
    /// Чтение значение из Keychain и преобразование его в `Int`
    /// - Parameter key: Ключ, по которому происходит чтение
    func getInt(key: String) -> Int?
    
    /// Удаление данных, сохранённых по указанному ключу
    /// - Parameter key: Ключ, по которому происходит удаление
    func remove(_ key: String)
}

final class KeyChainService: KeyChainServiceProtocol {
    
    // MARK: - Private Properties
    
    private let keychain = Keychain(service: "ru.ikozlov.MovieDBStorage")
    
    // MARK: - Public methods
    
    func save(_ bytes: [UInt8], key: String) {
        keychain[data: key] = Data(bytes)
    }
    
    func save(_ value: String, key: String) {
        keychain[key] = value
    }
    
    func save(_ value: Int, key: String) {
        keychain[key] = String(value)
    }
    
    func getBytes(key: String) -> [UInt8]? {
        guard let data = keychain[data: key] else { return nil }
        return [UInt8](data)
    }
    
    func getString(key: String) -> String? {
        guard let value = keychain[key] else { return nil }
        return value
    }
    
    func getInt(key: String) -> Int? {
        guard let value = keychain[key] else { return nil }
        return Int(value)
    }
    
    func remove(_ key: String) {
        try? keychain.remove(key)
    }
}
