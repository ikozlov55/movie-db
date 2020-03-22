//
//  JSONEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 21.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// `Endpoint` с JSON в теле ответа
protocol JSONEndpoint: Endpoint where Content: Decodable {}

extension JSONEndpoint {
    public func content(from data: Data, response: URLResponse?) throws -> Content {
        guard let response = response as? HTTPURLResponse,
            let statusCode = HTTPStatus(rawValue: response.statusCode)
            else {
                throw APIError.unknown
        }
        let decoder = MovieDBCoder.decoder
        guard statusCode == .ok else {
            switch statusCode {
            case .unauthorized, .badRequest, .notFound:
                throw try decoder.decode(ErrorDTO.self, from: data)
            default:
                throw APIError.server
            }
        }
        return try decoder.decode(Content.self, from: data)
    }
}
