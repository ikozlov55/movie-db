//
//  JSONRequestEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

protocol JSONRequestEndpoint: Endpoint {
    associatedtype Body: Encodable
    var coder: Coder { get }
    var body: Body { get }
}

extension JSONRequestEndpoint {
    var encoder: JSONEncoder { coder.encoder }
}
