//
//  CloseSessionEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public class CloseSessionEndpoint: JSONRequestEndpoint, VoidResponseEndpoint {
    internal let coder: Coder = MovieDBCoder()
    
    var body: CloseSessionRequestDTO
    
    init(sessionId: String) {
        body = CloseSessionRequestDTO(sessionId: sessionId)
    }
    
    public func makeRequest() throws -> URLRequest {
        var request = URLRequest(url: Authentication.closeSession.url)
        request.setHttpMethod(.DELETE)
        return request
    }
    
}
