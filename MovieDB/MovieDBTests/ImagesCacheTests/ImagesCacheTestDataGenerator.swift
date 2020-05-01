//
//  ImagesCacheTestDataGenerator.swift
//  MovieDBTests
//
//  Created by Илья Козлов on 27.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation
import Security

final class ImagesCacheTestDataGenerator {
    
    private let session = URLSession.shared
    
    func randomRequest() -> URLRequest {
        URLRequest(url: randomImageURL())
    }
    
    func randomDataTask(for request: URLRequest) -> URLSessionDataTask {
        session.dataTask(with: request)
    }
    
    func randomDataTask() -> URLSessionDataTask {
        session.dataTask(with: randomRequest())
    }
    
    func randomResponse() -> CachedURLResponse {
        CachedURLResponse(
            response: URLResponse(
                url: randomImageURL(),
                mimeType: "application/json",
                expectedContentLength: 100,
                textEncodingName: "UTF-8"
            ),
            data: randomData()
        )
    }
    
    func randomImageURL() -> URL {
        let address = "https://image.tmdb.org/t/p/w500/\(UUID().uuidString).jpg"
        return URL(string: address)!
    }
    
    func randomData() -> Data {
        UUID().uuidString.data(using: .utf8)!
    }
}
