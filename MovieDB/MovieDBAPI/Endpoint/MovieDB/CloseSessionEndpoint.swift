//
//  CloseSessionEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final public class CloseSessionEndpoint: VoidResponseEndpoint {
    private let body: CloseSessionRequestDTO
    
    public init(body: CloseSessionRequestDTO) {
        self.body = body
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.jsonBodyRequest(
            .DELETE,
            Config.baseUrl,
            path: "/authentication/session",
            parameters: Config.sessionParameters,
            body: body
        )
    }
    
}
