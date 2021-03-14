//
//  CryptoNetworkResult.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

enum CryptoNetworkResult {
    case success(data: Data)
    case failure(with: CryptoNetworkError)
    
    enum CryptoNetworkError {
        case notFound
        case serverError(error: Error)
        case parserError
        case defaultError
    }
}
