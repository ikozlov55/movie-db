//
//  VoidResponseEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

protocol VoidResponseEndpoint: Endpoint where Content == Void {}

extension VoidResponseEndpoint {
    public func content(from data: Data, response: URLResponse?) throws {}
}
