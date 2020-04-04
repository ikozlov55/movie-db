//
//  ValidateTokenEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// `Endpoint` валидации временного токена авторизации по имени пользователя и паролю
final public class ValidateTokenEndpoint: JSONEndpoint {
    public typealias Content = GetNewTokenDTO
    
    private let body: ValidateTokenRequestDTO
    
    public init(body: ValidateTokenRequestDTO) {
        self.body = body
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.jsonBodyRequest(
            .POST,
            Config.baseUrl,
            path: "/authentication/token/validate_with_login",
            parameters: Config.sessionParameters,
            body: body
        )
    }
}
