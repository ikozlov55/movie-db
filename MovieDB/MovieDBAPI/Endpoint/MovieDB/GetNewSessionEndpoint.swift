//
//  GetNewSessionEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final public class GetNewSessionEndpoint: JSONEndpoint {
    public typealias Content = GetNewSessionDTO
    
    private let body: GetNewSessionRequestDTO
    
    public init(body: GetNewSessionRequestDTO) {
        self.body = body
    }
    
    public func makeRequest() throws -> URLRequest {
        try URLRequest.jsonBodyRequest(
            .POST,
            Config.baseUrl,
            path: "/authentication/session/new",
            parameters: Config.sessionParameters,
            body: body
        )
    }
    
}
