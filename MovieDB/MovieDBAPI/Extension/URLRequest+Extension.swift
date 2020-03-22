//
//  URLRequest+Extension.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

extension URLRequest {
    
    static func jsonBodyRequest<T: Encodable>(
        _ method: HTTPMethod,
        _ baseUrl: URL,
        path: String,
        parameters: [String: Any] = [:],
        body: T,
        encoder: JSONEncoder = MovieDBCoder.encoder
    ) throws -> URLRequest {
        var request = try plainRequest(baseUrl, path: path, parameters: parameters)
        request.setHttpMethod(method)
        request.addContentType(.json)
        request.httpBody = try encoder.encode(body)
        return request
    }
    
    static func plainRequest(
        _ baseUrl: URL,
        path: String,
        parameters: [String: Any] = [:]
    ) throws -> URLRequest {
        guard var components = URLComponents(
            url: baseUrl.appendingPathComponent(path),
            resolvingAgainstBaseURL: true
            ) else {
                throw APIError.invalidUrl
        }
        components.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        guard let url = components.url else {
            throw APIError.invalidUrl
        }
        
        return URLRequest(url: url)
    }
    
    mutating func addContentType(_ type: ContentType) {
        self.addValue(type.rawValue, forHTTPHeaderField: "Content-Type")
    }
    
    mutating func setHttpMethod(_ method: HTTPMethod) {
        self.httpMethod = method.rawValue
    }
}
