//
//  ValidateTokenEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final public class ValidateTokenEndpoint: JSONRequestEndpoint, JSONResponseEndpoint {
    public typealias Content = GetNewTokenDTO
    
    internal let coder: Coder = MovieDBCoder()
    internal let body: ValidateTokenRequestDTO
    
    public init(username: String, password: String, requestToken: String) {
        body = ValidateTokenRequestDTO(
            username: username,
            password: password,
            requestToken: requestToken
        )
    }
    
    public func makeRequest() throws -> URLRequest {
        var request = URLRequest(url: Authentication.tokenValidateWithLogin.url)
        request.setHttpMethod(.POST)
        request.httpBody = try encoder.encode(body)
        request.addContentType(.json)
        return request
    }
}
