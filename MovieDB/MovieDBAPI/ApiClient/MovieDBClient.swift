//
//  MovieDBClient.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Реализация `APIClient` для работы с API themoviedb.org
final public class MovieDBClient: APIClient {
    
    // MARK: - Private Properties
    
    private let session: URLSession
    public var logger: Logger?
    
    // MARK: - Init
    
    /// - Parameters:
    ///   - configuration: Конфигурация `URLSession`  клиена, по умолчанию `.ephemeral`
    ///   - logger: `Logger` HTTP взаимодействия
    public init(
        configuration: URLSessionConfiguration = .ephemeral,
        logger: Logger? = nil
    ) {
        session = URLSession(configuration: configuration)
        self.logger = logger
    }
    
    // MARK: - Public methods
    
    public func request<T>(
        _ endpoint: T,
        completion: @escaping (Result<T.Content, Error>) -> Void
    ) -> Progress where T: Endpoint {
        do {
            let request = try endpoint.makeRequest()
            logger?.log(request)
            let task = session.dataTask(with: request) { [weak self] data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let response = response,
                    let data = data
                    else {
                        completion(.failure(APIError.unknown))
                        return
                }
                self?.logger?.log(response)
                self?.logger?.log(data)
                do {
                    let content = try endpoint.content(from: data, response: response)
                    completion(.success(content))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
            return task.progress
        } catch {
            completion(.failure(error))
            return Progress()
        }
    }
    
}
