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
            
            do {
                let image = try endpoint.content(from: data, response: response)
                self?.succeedOnMainThread(image, completion)
            } catch {
                self?.failOnMainThread(error, completion)
            }
        }
        task.resume()
        return task.progress
    }
    
}
