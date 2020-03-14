//
//  AuthService.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import Moya

protocol AuthServiceProtocol {
    func login(
        username: String,
        password: String,
        success: ((String) -> Void)?,
        failure: ((AuthService.Error) -> Void)?
    )
}

final class AuthService: AuthServiceProtocol {
    enum Error {
        case invalidToken
        case invalidCredentials
        case network
        case unknown
    }
    
    static let shared = AuthService()
    
    // MARK: - Private Properties
    
    private let provider: MoyaProvider<MovieDBApi>
    private let decoder = JSONDecoder()
    private let apiKey = "078d0533a0b06401c117b0818a7b1e99"
    
    // MARK: - Init
    
    private init() {
        let config = NetworkLoggerPlugin.Configuration(
            logOptions: [
                .requestMethod,
                .requestBody,
                .successResponseBody,
                .errorResponseBody
            ]
        )
        let logger = NetworkLoggerPlugin(configuration: config)
        provider = MoyaProvider<MovieDBApi>(plugins: [logger])
    }
    
    // MARK: - Private Methods
    
    private func getNewToken(success: ((String) -> Void)? = nil, failure: ((Error) -> Void)? = nil) {
        provider.request(.authTokenNew(apiKey: apiKey)) { [weak self] result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    break
                case 401:
                    failure?(Error.invalidToken)
                    return
                default:
                    failure?(Error.network)
                    return
                }
                guard
                    let responseDTO = try? self?.decoder.decode(GetNewTokenDTO.self, from: response.data)
                    else {
                        failure?(Error.unknown)
                        return
                }
                success?(responseDTO.requestToken)
            case .failure:
                failure?(Error.unknown)
            }
        }
    }
    
    private func validate(
        token: String,
        username: String,
        password: String,
        success: ((String) -> Void)? = nil,
        failure: ((Error) -> Void)? = nil) {
        provider.request(.authTokenValidateWithLogin(
            apiKey: apiKey,
            username: username,
            password: password,
            requestToken: token)) { [weak self] result in
                switch result {
                case .success(let response):
                    switch response.statusCode {
                    case 200:
                        break
                    case 401:
                        failure?(Error.invalidCredentials)
                        return
                    default:
                        failure?(Error.network)
                        return
                    }
                    guard
                        let responseDTO = try? self?.decoder.decode(GetNewTokenDTO.self, from: response.data)
                        else {
                            failure?(Error.unknown)
                            return
                    }
                    success?(responseDTO.requestToken)
                case .failure:
                    failure?(Error.unknown)
                }
        }
    }
    
    private func getNewSessionId(
        withToken token: String,
        success: ((String) -> Void)? = nil,
        failure: ((Error) -> Void)? = nil) {
        provider.request(.authSessionNew(
            apiKey: apiKey,
            requestToken: token)) { [weak self] result in
                switch result {
                case .success(let response):
                    switch response.statusCode {
                    case 200:
                        break
                    case 401:
                        failure?(Error.invalidCredentials)
                        return
                    default:
                        failure?(Error.network)
                        return
                    }
                    guard
                        let responseDTO = try? self?.decoder.decode(GetNewSessionDTO.self, from: response.data)
                        else {
                            failure?(Error.unknown)
                            return
                    }
                    success?(responseDTO.sessionId)
                case .failure:
                    failure?(Error.unknown)
                }
        }
    }
    
    // MARK: - Public methods
    
    func login(
        username: String,
        password: String,
        success: ((String) -> Void)? = nil,
        failure: ((Error) -> Void)? = nil) {
        getNewToken(
            success: { [weak self] token in
                self?.validate(
                    token: token,
                    username: username,
                    password: password,
                    success: { [weak self] token in
                        self?.getNewSessionId(
                            withToken: token,
                            success: { sessionId in success?(sessionId) },
                            failure: { error in failure?(error); return }
                        )
                    },
                    failure: { error in failure?(error); return }
                )
            },
            failure: { error in failure?(error); return }
        )
    }
    
}
