//
//  Logger.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

protocol Logger {
    var isActive: Bool { get set }
    func log(_ request: URLRequest)
    func log(_ response: HTTPURLResponse)
    func log(_ responseData: Data)
}

class PrintLogger: Logger {
    
    var isActive: Bool
    
    init(isActive: Bool) {
        self.isActive = isActive
    }
    
    func log(_ request: URLRequest) {
        guard isActive else { return }
        guard
            let method = request.httpMethod,
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
