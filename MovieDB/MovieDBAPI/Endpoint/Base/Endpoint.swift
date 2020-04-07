//
//  Endpoint.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Тип, обязанность которого - подготовить URLRequest  запрос, обработать возможные ошибки
/// и собрать результат типа Content из полученных данных с сервера
public protocol Endpoint {
    /// Тип резлуьтата. полченного после обработки ответа сервера
    associatedtype Content
    
    /// Создание `URLRequest` запроса
    func makeRequest() throws -> URLRequest
    
    /// Обработка ответа сервера и получение результата типа `Content`
    /// - Parameters:
    ///   - data: `Data` тела ответа
    ///   - response: `URLResponse` ответ
    func content(from data: Data, response: URLResponse?) throws -> Content
}
