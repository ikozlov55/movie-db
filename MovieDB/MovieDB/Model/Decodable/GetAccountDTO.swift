//
//  GetAccountDTO.swift
//  MovieDB
//
//  Created by Илья Козлов on 09.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

struct GetAccountDTO: Decodable {
    let id: Int
    let name: String
    let username: String
}
