//
//  Logger.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Тип, ответсвенность которого, логировать HTTP взаимодествие в `APIClient`
public protocol Logger {
    
    /// Признак активности логгера а данный момент
    var isActive: Bool { get set }
    
    /// Логирование HTTP запроса
    /// - Parameter request: запрос
    func log(_ request: URLRequest)
    
    /// Логирование ответа `URLResponse`
    /// - Parameter response: ответ
    func log(_ response: URLResponse)
    
    /// Логирование бинарных данных тела ответа или запроса
    /// - Parameter data: данные
    func log(_ data: Data)
}

/// `Logger` который выводит лог в терминал с помощью простых вызовов функции `print`
public final class PrintLogger: Logger {
    
    public var isActive: Bool
    
    public init(isActive: Bool = true) {
        self.isActive = isActive
    }
    
    public func log(_ request: URLRequest) {
        guard isActive else { return }
        guard let method = request.httpMethod,
            let url = request.url
            else {
                print("\n invalid request \n")
                return
        }
        print("\(method) \(url.absoluteString)\n")
        if let data = request.httpBody {
            log(data)
        }
    }
    
    public func log(_ response: URLResponse) {
        guard isActive,
            let response = response as? HTTPURLResponse
            else { return }
        let code = response.statusCode
        let description = HTTPURLResponse.localizedString(forStatusCode: code)
        print("\(code) - \(description.capitalized)\n")
    }
    
    public func log(_ data: Data) {
        guard isActive else { return }
        if let dataString = String(data: data, encoding: .utf8) {
            print("\(dataString)\n")
        }
    }
    
}
