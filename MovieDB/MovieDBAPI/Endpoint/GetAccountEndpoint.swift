//
//  GetAccountEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public class GetAccountEndpoint: JSONResponseEndpoint {
    public typealias Content = GetAccountDTO
    
    var coder: Coder = MovieDBCoder()

    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        URLRequest(url: Account.account.url)
    }
    
}
