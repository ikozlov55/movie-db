//
//  APIClient.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Тип, отвечающий за HTTP взаимодействие с api
public protocol APIClient: AnyObject {
    
    /// Получение и отправка HTTP запроса, полученного из endpoint
    /// - Parameters:
    ///   - endpoint: Вызываемый эндпоинт api
    ///   - completion: Замыкание, вызываемое для обработки результатов запрос
    @discardableResult
    func request<T>(
        _ endpoint: T,
        completion: @escaping (Result<T.Content, Error>) -> Void
    ) -> Progress where T: Endpoint
    
}
