//
//  GetNewTokenEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public class GetNewTokenEndpoint: JSONResponseEndpoint {
    public typealias Content = GetNewTokenDTO
    
    internal let coder: Coder = MovieDBCoder()
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        URLRequest(url: Authentication.tokenNew.url)
    }
    
}
