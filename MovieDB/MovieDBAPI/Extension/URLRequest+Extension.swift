//
//  URLRequest+Extension.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

enum ContentType: String {
    case json = "application/json"
}

extension URLRequest {
    mutating func addContentType(_ type: ContentType) {
        self.addValue(type.rawValue, forHTTPHeaderField: "Content-Type")
    }
    
    mutating func setHttpMethod(_ method: HTTPMethod) {
        self.httpMethod = method.rawValue
    }
}
