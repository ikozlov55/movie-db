//
//  PinAuthorizationService.swift
//  MovieDB
//
//  Created by Илья Козлов on 20.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import MovieDBAPI

/// Тип, ответсвенный за создание, удаление и проверку пин-кода
protocol PinAuthorizationServiceProtocol {
    
    /// Признак - сохранёны ли уже в системе данные сессии для дальнейшего получения к ним доступа с помощью пин-кода
    var credentialsFound: Bool { get }
    
    /// Запись данных сессии в Keychain
    /// - Parameter pin: Установленный пользователем пин-код
    func setCredentials(_ pin: String)
    
    /// Удаление сохранённых в системе данных сессии
    func clearCredentials()
    
    /// Проверка введённого пользователем пин-кода
    /// - Parameter pin: Введённый пользователем пин-код, который необходимо проверить
    func isPinCorrect(_ pin: String) -> Bool
}

final class PinAuthorizationService: PinAuthorizationServiceProtocol {
    
    enum Keys: String, CaseIterable {
        case sessionId
        case salt
        case pin
        case accountId
        case userName
    }
    // MARK: - Private Properties
    
    private let cryptoService = ServiceLayer.cryptoService
    private let keyChainService = KeyChainService()
    
    // MARK: - Public methods
    
    var credentialsFound: Bool {
        guard keyChainService.getBytes(key: Keys.salt.rawValue) != nil,
            keyChainService.getBytes(key: Keys.sessionId.rawValue) != nil
            else { return false }
        return true
    }
    
    func setCredentials(_ pin: String) {
        guard let salt = cryptoService.makeSalt(),
            let key = cryptoService.makePBKDF2Key(password: pin, salt: salt),
            let sessionId = Config.sessionId,
            let encryptedSessionId = cryptoService.encrypt(string: sessionId, key: key)
            else { return }
        
        keyChainService.save(encryptedSessionId, key: Keys.sessionId.rawValue)
        keyChainService.save(salt, key: Keys.salt.rawValue)
        keyChainService.save(Config.accountId, key: Keys.accountId.rawValue)
        keyChainService.save(Config.userName, key: Keys.userName.rawValue)
    }
    
    func clearCredentials() {
        Keys.allCases.forEach { keyChainService.remove($0.rawValue) }
    }
    
    func isPinCorrect(_ pin: String) -> Bool {
        guard
            let salt = keyChainService.getBytes(key: Keys.salt.rawValue),
            let encryptedSessionId = keyChainService.getBytes(key: Keys.sessionId.rawValue),
            let key = cryptoService.makePBKDF2Key(password: pin, salt: salt),
            let decryptedSessionIdData = cryptoService.decrypt(data: encryptedSessionId, key: key),
            let decryptedSessionId = String(bytes: decryptedSessionIdData, encoding: .utf8)
            else { return false }
        Config.sessionId = decryptedSessionId
        restoreAccountData()
        return true
    }
    
    // MARK: - Private Methods
    
    private func restoreAccountData() {
        Config.accountId = keyChainService.getInt(key: Keys.accountId.rawValue) ?? 0
        Config.userName = keyChainService.getString(key: Keys.userName.rawValue) ?? ""
    }
}
