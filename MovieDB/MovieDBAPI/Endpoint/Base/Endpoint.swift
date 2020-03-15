//
//  Endpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public protocol Endpoint {
    associatedtype Content
    
    func makeRequest() throws -> URLRequest
    func content(from data: Data, response: URLResponse?) throws -> Content
}
