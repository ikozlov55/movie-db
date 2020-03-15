//
//  GetNewSessionEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public class GetNewSessionEndpoint: JSONRequestEndpoint, JSONResponseEndpoint {
    public typealias Content = GetNewSessionDTO
    
    internal let coder: Coder = MovieDBCoder()
    
    internal let body: GetNewSessionRequestDTO
    
    public init(requestToken: String) {
        body = GetNewSessionRequestDTO(requestToken: requestToken)
    }
    
    public func makeRequest() throws -> URLRequest {
        var request = URLRequest(url: Authentication.sessionNew.url)
        request.setHttpMethod(.POST)
        request.httpBody = try encoder.encode(body)
        request.addContentType(.json)
        return request
    }
}
