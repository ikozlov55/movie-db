//
//  PathEnum.swift
//  MovieDBAPI
//
//  Created by Илья Козлов on 15.03.2020.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import Foundation

protocol URLConvertable {
    var url: URL { get }
}

extension URLConvertable where Self: RawRepresentable, RawValue == String {
    var url: URL { URL(string: self.rawValue)! }
}

protocol AccountIdPath {
    func accountId(_ accountId: Int) -> URL
}

extension AccountIdPath where Self: RawRepresentable, RawValue == String {
    func accountId(_ accountId: Int) -> URL {
        let path = self.rawValue.replacingOccurrences(
            of: "{{accountId}}",
            with: String(describing: accountId)
        )
        return URL(string: path)!
    }
}

enum Authentication: String, URLConvertable {
    case tokenNew = "/authentication/token/new"
    case tokenValidateWithLogin = "/authentication/token/validate_with_login"
    case sessionNew = "/authentication/session/new"
    case closeSession = "/authentication/session"
}

enum Account: String, URLConvertable, AccountIdPath {
    case account
    case getFavoriteMovies = "account/{{accountId}}/favorite/movies"
    case addFavorite = "account/{{accountId}}/favorite"
}

enum Search: String, URLConvertable {
    case movie = "/search/movie"
}
