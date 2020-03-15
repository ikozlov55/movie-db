//
//  APIClient.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 14.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

protocol APIClient: AnyObject {
    
    @discardableResult
    func request<T>(
        _ endpoint: T,
        completion: @escaping (Result<T.Content, Error>) -> Void
    ) -> Progress where T: Endpoint
    
}
