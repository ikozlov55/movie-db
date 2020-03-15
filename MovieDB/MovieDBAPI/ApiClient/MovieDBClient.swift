//
//  MovieDBClient.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

public class MovieDBClient: APIClient {
    
    // MARK: - Public Properties
    
    public var sessionId: String?
    
    // MARK: - Private Properties
    
    private let baseUrl: URL
    private let session = URLSession(configuration: .ephemeral)
    private let apiKey: String
    private var logger: Logger
    
    // MARK: - Init
    
    public init(baseUrl: URL, apiKey: String, logging: Bool = true) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.logger = PrintLogger(isActive: logging)
    }
    
    // MARK: - Public methods
    
    public func request<T>(
        _ endpoint: T,
        completion: @escaping (Result<T.Content, Error>) -> Void
    ) -> Progress where T: Endpoint {
        guard
            let request = makeFullRequest(endpoint)
            else {
                completion(.failure(.unknown))
                return Progress()
        }
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else {
                completion(.failure(.network))
                return
            }
            
            guard
                let response = response as? HTTPURLResponse,
                let statusCode = HTTPStatus(rawValue: response.statusCode),
                let data = data
                else {
                    completion(.failure(.unknown))
                    return
            }
            self?.logger.log(response)
            self?.logger.log(data)
            
            if let statusError = self?.handleStatusCode(statusCode) {
                completion(.failure(statusError))
                return
            }
            
            guard
                let content = try? endpoint.content(from: data, response: response)
                else {
                    completion(.failure(.decoding))
                    return
            }
            
            completion(.success(content))
        }
        task.resume()
        return task.progress
    }
    
    // MARK: - Private Methods
    
    private func makeFullRequest<T>(_ endpoint: T) -> URLRequest? where T: Endpoint {
        guard
            var request = try? endpoint.makeRequest(),
            let requestPath = request.url?.path,
            var components = URLComponents(
                url: baseUrl.appendingPathComponent(requestPath),
                resolvingAgainstBaseURL: true
            )
            else { return nil }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let sessionId = sessionId {
            queryItems.append(URLQueryItem(name: "session_id", value: sessionId))
        }
        components.queryItems = queryItems
        
        request.url = components.url
        logger.log(request)
        
        return request
    }
    
    private func handleStatusCode(_ statusCode: HTTPStatus) -> Error? {
        switch statusCode {
        case .ok:
            return nil
        case .serverError:
            return .server
        case .badRequest:
            return .invalidRequest
        case .unauthorized:
            return .invalidCredentials
        }
    }
    
}
