//
//  String+Extension.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import CommonCrypto
import Foundation

extension String {
    
    /// Строка без пробелов в начале и конце
    var trim: Self {
        self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
    
    /// SHA256 Хеш в виде строки
    func sha256() -> String {
        var result = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        let bytes = [UInt8](self.utf8)
        CC_SHA256(bytes, CC_LONG(bytes.count), &result)
        return result.compactMap { String(format: "%02x", $0) }.joined()
    }
    
}
