//
//  ImagesClient.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 18.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

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
                completion(.failure(APIError.invalidUrl))
                return Progress()
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse,
                let statusCode = HTTPStatus(rawValue: response.statusCode),
                statusCode == .ok,
                let data = data
                else {
                    completion(.failure(APIError.unknown))
                    return
            }
            
            do {
                let image = try endpoint.content(from: data, response: response)
                completion(.success(image))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
        return task.progress
    }
    
}
