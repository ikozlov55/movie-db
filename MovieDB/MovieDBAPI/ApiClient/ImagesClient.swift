//
//  ImagesClient.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 18.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Реализация `APIClient` для загрузки изображений из сети
public final class ImagesClient: APIClient {
    
    // MARK: - Private Properties
    
    private let session: URLSession
    
    // MARK: - Init
    
    public init(configuration: URLSessionConfiguration = .ephemeral) {
        session = URLSession(configuration: configuration)
    }
    
    // MARK: - Public methods
    
    public func request<T>(
        _ endpoint: T,
        completion: @escaping (Result<T.Content, Error>) -> Void
    ) -> Progress where T: Endpoint {
        guard let request = try? endpoint.makeRequest()
            else {
                failOnMainThread(APIError.invalidUrl, completion)
                return Progress()
        }
        
        if let cachedResponse = session.configuration.urlCache?.cachedResponse(for: request) {
            handleImageData(cachedResponse.data, nil, endpoint, completion)
            return Progress()
        }
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.failOnMainThread(error, completion)
            }
            
            guard let response = response as? HTTPURLResponse,
                let statusCode = HTTPStatus(rawValue: response.statusCode),
                statusCode == .ok,
                let data = data
                else {
                    self?.failOnMainThread(APIError.unknown, completion)
                    return
            }
            
            self?.handleImageData(data, response, endpoint, completion)
        }
        
        session.configuration.urlCache?.getCachedResponse(for: task) { cachedResponse in
            guard let response = cachedResponse else { return }
            self.handleImageData(response.data, nil, endpoint, completion)
        }
        
        task.resume()
        return task.progress
    }
    
    // MARK: - Private Methods
    
    private func handleImageData<T: Endpoint>(
        _ data: Data,
        _ response: HTTPURLResponse?,
        _ endpoint: T,
        _ completion: @escaping (Result<T.Content, Error>) -> Void) {
        do {
            let image = try endpoint.content(from: data, response: response)
            succeedOnMainThread(image, completion)
        } catch {
            failOnMainThread(error, completion)
        }
    }
    
}
