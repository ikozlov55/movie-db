//
//  CryptoService.swift
//  MovieDB
//
//  Created by Илья Козлов on 19.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import CommonCrypto
import Foundation
import Security

/// Тип, предоставляющий низкоуровневые криптографическии функции
protocol CryptoServiceProtocol {
    
    /// Генерация соли заданной длина
    /// - Parameter numberOfBytes: Длина массива байт в итоговой соли, по умолчанию 32
    func makeSalt(numberOfBytes: Int) -> [UInt8]?
    
    /// Формирование ключа ключа на основе заданного пароля и соли по стандарту PBKDF2
    /// - Parameters:
    ///   - password: Пароль
    ///   - salt: Соль
    ///   - rounds: Количество итераций вызова хеширующей функции, по умолчанию 5000
    ///   - keyLength: Длина итогового ключа, по учмолчанию  = `kCCKeySizeAES256` - 32
    func makePBKDF2Key(password: String, salt: [UInt8], rounds: Int, keyLength: Int) -> [UInt8]?
    
    /// Шифрование массива данных переданным ключом по алгоритму AES - ECB
    /// - Parameters:
    ///   - data: Данные, которые необходимо зашифровать
    ///   - key: Ключ, который испольуется при шифровании
    func encrypt(data: [UInt8], key: [UInt8]) -> [UInt8]?
    
    /// Шифрование строки переданным ключом по алгоритму AES - ECB
    /// - Parameters:
    ///   - string: Строка, которую необходимо зашифровать
    ///   - key: Ключ, который испольуется при шифровании
    func encrypt(string: String, key: [UInt8]) -> [UInt8]?
    
    /// Дешифрование массива данных переданным ключом по алгоритму AES - ECB
    /// - Parameters:
    ///   - data: Данные, которые необходимо дешифровать
    ///   - key: Ключ, который испольуется при дешифровании
    func decrypt(data: [UInt8], key: [UInt8]) -> [UInt8]?
}

// Расширание протокола методами со значениями по умолчанию
extension CryptoServiceProtocol {
    
    func makeSalt(numberOfBytes: Int = 32) -> [UInt8]? {
        makeSalt(numberOfBytes: numberOfBytes)
    }
    
    func makePBKDF2Key(
        password: String,
        salt: [UInt8],
        rounds: Int = 5000,
        keyLength: Int = kCCKeySizeAES256) -> [UInt8]? {
        makePBKDF2Key(password: password, salt: salt, rounds: rounds, keyLength: keyLength)
    }
    
}

final class CryptoService: CryptoServiceProtocol {
    
    // MARK: - Public Properties
    
    func makeSalt(numberOfBytes: Int = 32) -> [UInt8]? {
        var bytes = [UInt8](repeating: 0, count: numberOfBytes)
        let status = SecRandomCopyBytes(kSecRandomDefault, numberOfBytes, &bytes)
        guard status == errSecSuccess else { return nil }
        
        return bytes
    }
    
    func makePBKDF2Key(
        password: String,
        salt: [UInt8],
        rounds: Int = 5000,
        keyLength: Int = kCCKeySizeAES256) -> [UInt8]? {
        var key = [UInt8](repeating: 0, count: keyLength)
        let status = CCKeyDerivationPBKDF(
            CCPBKDFAlgorithm(kCCPBKDF2),
            password,
            password.count,
            salt,
            salt.count,
            CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256),
            UInt32(rounds),
            &key,
            keyLength
        )
        guard status == kCCSuccess else { return nil }
        
        return key
    }
    
    func encrypt(data: [UInt8], key: [UInt8]) -> [UInt8]? {
        crypt(data: data, key: key, operation: CCOperation(kCCEncrypt))
    }
    
    func encrypt(string: String, key: [UInt8]) -> [UInt8]? {
        guard let stringData = string.data(using: .utf8) else { return nil }
        let data = [UInt8](stringData)
        return crypt(data: data, key: key, operation: CCOperation(kCCEncrypt))
    }
    
    func decrypt(data: [UInt8], key: [UInt8]) -> [UInt8]? {
        crypt(data: data, key: key, operation: CCOperation(kCCDecrypt))
    }
    
    // MARK: - Private Properties
    
    private func crypt(data: [UInt8], key: [UInt8], operation: CCOperation) -> [UInt8]? {
        let resultLength = data.count + kCCBlockSizeAES128
        var result = [UInt8](repeating: 0, count: resultLength)
        var cryptBytes = 0
    
        let status = CCCrypt(
            operation,
            CCAlgorithm(kCCAlgorithmAES),
            CCOptions(kCCOptionPKCS7Padding | kCCOptionECBMode),
            key,
            key.count,
            nil,
            data,
            data.count,
            &result,
            resultLength,
            &cryptBytes
        )
        guard status == kCCSuccess else { return nil }
        result.removeSubrange(cryptBytes..<result.count)
        
        return result
    }
    
}
