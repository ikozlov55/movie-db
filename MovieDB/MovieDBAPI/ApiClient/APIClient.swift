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

extension APIClient {
    
    /// Завершение работы метода `request` с ошибкой в главном потоке
    /// - Parameters:
    ///   - error: Ошибка, возникшая в ходе отправки или обработки запроса в методе `request`
    ///   - completion: Замыкание, переданное на вход методу `request`
    func failOnMainThread<Content>(
        _ error: Error,
        _ completion: @escaping (Result<Content, Error>) -> Void
    ) {
        DispatchQueue.main.async {
            completion(.failure(error))
        }
    }
    
    /// Успешное завершение работы метода `request` в главном потоке
    /// - Parameters:
    ///   - result: Результат, полученный `Endpoint` в результате обработки ответа сервера
    ///   - completion: Замыкание, переданное на вход методу `request`
    func succeedOnMainThread<Content>(
        _ result: Content,
        _ completion: @escaping (Result<Content, Error>) -> Void) {
        DispatchQueue.main.async {
            completion(.success(result))
        }
    }
}
