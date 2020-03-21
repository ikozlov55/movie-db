//
//  JSONRequestEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// `Endpoint` с JSON телом в запросе
protocol JSONRequestEndpoint: Endpoint {
    
    /// `Encodable` тип тела запроса
    associatedtype Body: Encodable
    
    /// `Coder` для кодирование тела запроса
    var coder: Coder { get }
    
    /// Тело запроса
    var body: Body { get }
}

extension JSONRequestEndpoint {
    var encoder: JSONEncoder { coder.encoder }
}
