//
//  ImagesInMemoryCache.swift
//  MovieDB
//
//  Created by Илья Козлов on 25.04.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

final class ImagesInMemoryCache: URLCache {
    
    // MARK: - Private Properties
    
    private var storage: [String: CachedURLResponse] = [:]
    
    private let queue = DispatchQueue(label: "ImagesInMemoryCache", attributes: [.concurrent])
    
    // MARK: - URLCache Overrides
    
    override func storeCachedResponse(_ cachedResponse: CachedURLResponse, for dataTask: URLSessionDataTask) {
        guard let key = dataTask.currentRequest?.url?.absoluteString else {
            return
        }
        queue.async(flags: .barrier) { [weak self] in
            if self?.storage.index(forKey: key) == nil {
                self?.storage[key] = cachedResponse
            }
        }
    }
    
    override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        var result: CachedURLResponse?
        guard let key = request.url?.absoluteString else {
            return result
        }
        queue.sync {
            result = storage[key]
        }
        return result
    }
    
    override func removeCachedResponse(for dataTask: URLSessionDataTask) {
        guard let key = dataTask.currentRequest?.url?.absoluteString else {
            return
        }
        queue.async(flags: .barrier) { [weak self] in
            self?.storage.removeValue(forKey: key)
        }
    }
    
    override func removeAllCachedResponses() {
        queue.async(flags: .barrier) { [weak self] in
            self?.storage = [:]
        }
    }
}
