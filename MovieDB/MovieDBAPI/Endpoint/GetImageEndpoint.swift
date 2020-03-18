//
//  GetImageEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 18.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

final public class GetImageEndpoint: Endpoint {
    public typealias Content = UIImage

    private let address: String

    public init(address: String) {
        self.address = address
    }

    public func makeRequest() throws -> URLRequest {
        guard
            let url = URL(string: address)
            else {
                throw Error.invalidUrl
        }
        return URLRequest(url: url)
    }

    public func content(from data: Data, response: URLResponse?) throws -> UIImage {
        guard
            let image = UIImage(data: data)
            else {
                throw Error.unknown
        }
        return image
    }
}
