//
//  PinAuthorizationService.swift
//  MovieDB
//
//  Created by Илья Козлов on 20.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import LocalAuthentication
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
    
    /// Проверка введённого пользователем пин-кода и восстановление данных сессии из Keychain
    /// - Parameters:
    ///   - pin: Введённый пользователем пин-код, который необходимо проверить
    ///   - completion: Замыкание, которое выполняется после проверки. На вход получет результат проверки типа `Bool`
    func checkPin(_ pin: String, completion: (Bool) -> Void)
    
    /// Восстановление пин-кода  и данных сессии из Keychain с использованием биометрии
    /// - Parameter completion: Замыкание, которое выполняется после проверки. На вход получет результат проверки типа `Bool`
    func checkBiometrics(completion: @escaping (Bool) -> Void)
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
    private let keychain = ServiceLayer.keychainService
    
    // MARK: - Public methods
    
    var credentialsFound: Bool {
        guard keychain.getBytes(key: Keys.salt.rawValue) != nil,
            keychain.getBytes(key: Keys.sessionId.rawValue) != nil
            else { return false }
        return true
    }
    
    func setCredentials(_ pin: String) {
        guard let salt = cryptoService.makeSalt(),
            let key = cryptoService.makePBKDF2Key(password: pin, salt: salt),
            let sessionId = Config.sessionId,
            let encryptedSessionId = cryptoService.encrypt(string: sessionId, key: key)
            else { return }
        
        keychain.save(encryptedSessionId, key: Keys.sessionId.rawValue)
        keychain.save(salt, key: Keys.salt.rawValue)
        keychain.save(Config.accountId, key: Keys.accountId.rawValue)
        keychain.save(Config.userName, key: Keys.userName.rawValue)
        
        storePinWithBiometrics(pin)
    }
    
    func clearCredentials() {
        Keys.allCases.forEach { keychain.remove($0.rawValue) }
    }
    
    func checkPin(_ pin: String, completion: (Bool) -> Void) {
        guard
            let salt = keychain.getBytes(key: Keys.salt.rawValue),
            let encryptedSessionId = keychain.getBytes(key: Keys.sessionId.rawValue),
            let key = cryptoService.makePBKDF2Key(password: pin, salt: salt),
            let decryptedSessionIdData = cryptoService.decrypt(data: encryptedSessionId, key: key),
            let decryptedSessionId = String(bytes: decryptedSessionIdData, encoding: .utf8)
            else {
                completion(false)
                return
        }
        Config.sessionId = decryptedSessionId
        restoreAccountData()
        completion(true)
    }
    
    func checkBiometrics(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        context.localizedCancelTitle = "OK"
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            completion(false)
            return
        }
        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: L10n.authorizationReason) { [weak self] success, _ in
                guard success,
                    let pin = self?.keychain.getString(key: Keys.pin.rawValue) else {
                        completion(false)
                        return
                }
                DispatchQueue.main.async {
                    self?.checkPin(pin, completion: completion)
                }
        }
    }
    
    // MARK: - Private Methods
    
    private func storePinWithBiometrics(_ pin: String) {
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else { return }
        keychain.save(pin, key: Keys.pin.rawValue)
    }
    
    private func restoreAccountData() {
        Config.accountId = keychain.getInt(key: Keys.accountId.rawValue) ?? 0
        Config.userName = keychain.getString(key: Keys.userName.rawValue) ?? ""
    }
}
