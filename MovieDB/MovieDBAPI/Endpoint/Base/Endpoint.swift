//
//  Endpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Тип, обязанность которого - подготовить URLRequest  запрос и собрать результат типа Content из полученного ответа
public protocol Endpoint {
    /// Тип полученного ответа
    associatedtype Content
    
    /// Подготовка запроса
    func makeRequest() throws -> URLRequest
    
    /// Сборка ответа
    /// - Parameters:
    ///   - data: `Data` тела ответа
    ///   - response: `URLResponse` ответ
    func content(from data: Data, response: URLResponse?) throws -> Content
}
