//
//  ImagesService.swift
//  MovieDB
//
//  Created by Илья Козлов on 31.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import MovieDBAPI
import UIKit

/// Тип, отвечающий за загрузку изображений из сети
protocol ImagesServiceProtocol {
    
    /// Загрузка изображений по `URL`
    /// - Parameters:
    ///   - url: `URL` изображения
    ///   - completion: Замыкание, на вход получает список `UIImage` или ошибку
    func load(
        _ url: URL,
        completion: @escaping ((Result<UIImage, Error>) -> Void)) -> Progress
}

final class ImagesService: ImagesServiceProtocol {
    
    // MARK: - Private Properties
    
    private let apiClient: APIClient
    
    // MARK: - Init
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func load(
        _ url: URL,
        completion: @escaping ((Result<UIImage, Error>) -> Void)) -> Progress {
        apiClient.request(GetImageEndpoint(url: url)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
