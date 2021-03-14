//
//  CryptoRequest.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

typealias ServiceCallback = (_ status: CryptoNetworkResult) -> Void

class Request {
    var urlString: String
    var httpMethod: HTTPMethod
    var queries: [URLQueryItem] = []
    var onBaseCallback: ServiceCallback?
    
    var url: URL? {
        return URL(string: urlString)
    }
    
    var method: String? {
        return httpMethod.rawValue
    }
    
    init(urlString: String, method: HTTPMethod = .get) {
        self.urlString = urlString
        self.httpMethod = method
    }
}
