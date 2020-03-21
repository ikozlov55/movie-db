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

    private let session = URLSession(configuration: .ephemeral)

    // MARK: - Init

    public init() {}

    // MARK: - Public methods

    public func request<T>(
        _ endpoint: T,
        completion: @escaping (Result<T.Content, APIError>) -> Void
    ) -> Progress where T: Endpoint {
        guard let request = try? endpoint.makeRequest()
            else {
                completion(.failure(.invalidUrl))
                return Progress()
        }

        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.network))
            }
            guard let data = data,
                let image = try? endpoint.content(from: data, response: response)
                else {
                    completion(.failure(.unknown))
                    return
            }
            completion(.success(image))
        }
        task.resume()
        return task.progress
    }

}
