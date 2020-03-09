//
//  MovieDBApi.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import Moya

enum MovieDBApi {
    case authTokenNew(apiKey: String)
    case authTokenValidateWithLogin(
        apiKey: String,
        username: String,
        password: String,
        requestToken: String
    )
    case authSessionNew(apiKey: String, requestToken: String)
    case authSessionClose(apiKey: String)
    case account(apiKey: String, sessionId: String)
}

// MARK: - TargetType Protocol Implementation

extension MovieDBApi: TargetType {
    
    var baseURL: URL { URL(string: "https://api.themoviedb.org/3")! }
    
    var path: String {
        switch self {
        case .authTokenNew:
            return "/authentication/token/new"
        case .authTokenValidateWithLogin:
            return "/authentication/token/validate_with_login"
        case .authSessionNew:
            return "/authentication/session/new"
        case .authSessionClose:
            return "/authentication/session"
        case .account:
            return "/account"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .authTokenNew:
            return .get
        case .authTokenValidateWithLogin:
            return .post
        case .authSessionNew:
            return .post
        case .authSessionClose:
            return .delete
        case .account:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .authTokenNew(apiKey):
            return .requestParameters(
                parameters: ["api_key": apiKey],
                encoding: URLEncoding.queryString
            )
        case .authTokenValidateWithLogin(let apiKey, let username, let password, let requestToken):
            return .requestCompositeParameters(
                bodyParameters: [
                    "username": username,
                    "password": password,
                    "request_token": requestToken
                ],
                bodyEncoding: JSONEncoding.default,
                urlParameters: ["api_key": apiKey]
            )
        case .authSessionNew(let apiKey, let requestToken):
            return .requestCompositeParameters(
                bodyParameters: ["request_token": requestToken],
                bodyEncoding: JSONEncoding.default,
                urlParameters: ["api_key": apiKey]
            )
        case .authSessionClose(let apiKey):
            return .requestParameters(
                parameters: ["api_key": apiKey],
                encoding: URLEncoding.queryString
            )
        case .account(let apiKey, let sessionId):
            return .requestParameters(
                parameters: ["api_key": apiKey, "session_id": sessionId],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var sampleData: Data {
        switch self {
        case .authTokenNew:
            return "".data(using: .utf8)!
        case .authTokenValidateWithLogin:
            return "".data(using: .utf8)!
        case .authSessionNew:
            return "".data(using: .utf8)!
        case .authSessionClose:
            return "".data(using: .utf8)!
        case .account:
            return "".data(using: .utf8)!
        }
    }
    
    var headers: [String: String]? { nil }
}
