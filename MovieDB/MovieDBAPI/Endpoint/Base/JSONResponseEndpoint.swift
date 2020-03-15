//
//  JSONResponseEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

protocol JSONResponseEndpoint: Endpoint where Content: Decodable {
    var coder: Coder { get }
}

extension JSONResponseEndpoint {
    var decoder: JSONDecoder { coder.decoder }
    
    public func content(from data: Data, response: URLResponse?) throws -> Content {
        try decoder.decode(Content.self, from: data)
    }
}
