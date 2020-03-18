//
//  Enum.swift
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
    case serverError = 500
}

public enum Error: Swift.Error {
    case network
    case server
    case invalidRequest
    case invalidCredentials
    case invalidUrl
    case tokenExpired
    case decoding
    case unknown
}
