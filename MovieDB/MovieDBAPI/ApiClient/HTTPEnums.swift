//
//  HTTPEnums.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    case DELETE
}

public enum HTTPStatus: Int {
    case ok = 200
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case serverError = 500
    case badGateway = 502
}

enum ContentType: String {
    case json = "application/json"
}

public enum APIError: Error {
    case server
    case invalidUrl
    case unknown
}
