//
//  GetImageEndpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 18.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

/// `Endpoint` получения `UIImage` из сети по `URL`
final public class GetImageEndpoint: Endpoint {
    public typealias Content = UIImage
    
    private let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public func makeRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        return request
    }
    
    public func content(from data: Data, response: URLResponse?) throws -> Content {
        guard let image = UIImage(data: data)
            else {
                throw APIError.unknown
        }
        return image
    }
}
