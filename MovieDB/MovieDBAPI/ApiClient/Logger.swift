//
//  Logger.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

/// Тип, ответсвенность которого, логировать HTTP взаимодествие в `APIClient`
protocol Logger {
    
    /// Признак активности логгера а данный момент
    var isActive: Bool { get set }
    
    /// Логирование HTTP запроса
    /// - Parameter request: запрос
    func log(_ request: URLRequest)
    
    /// Логирование ответа `HTTPURLResponse`
    /// - Parameter response: ответ
    func log(_ response: HTTPURLResponse)
    
    /// Логирование бинарных данных тела ответа или запроса
    /// - Parameter data: данные
    func log(_ data: Data)
}

/// `Logger` который выводит лог в терминал с помощью простых вызовов функции `print`
final class PrintLogger: Logger {
    
    var isActive: Bool
    
    init(isActive: Bool) {
        self.isActive = isActive
    }
    
    func log(_ request: URLRequest) {
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
    
    func log(_ response: HTTPURLResponse) {
        guard isActive else { return }
        let code = response.statusCode
        let description = HTTPURLResponse.localizedString(forStatusCode: code)
        print("\(code) - \(description.capitalized)\n")
    }
    
    func log(_ data: Data) {
        guard isActive else { return }
        if let dataString = String(data: data, encoding: .utf8) {
            print("\(dataString)\n")
        }
    }
    
}
