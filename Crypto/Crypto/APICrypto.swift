//
//  APICrypto.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

class APICrypto {
    
    class func getCrypto(bookId: String, completion: @escaping (_ status: CryptoNetworkResult) -> Void) {
        let request = Request(urlString: ServiceDefinitions.book)
        request.queries.append(URLQueryItem(name: "book", value: bookId))
        request.onBaseCallback = completion
        ServicesRequest.callService(with: request)
    }
    
    class func getCryptos(completion: @escaping (_ status: CryptoNetworkResult) -> Void) {
        let request = Request(urlString: ServiceDefinitions.availableBooks)
        request.onBaseCallback = completion
        ServicesRequest.callService(with: request)
    }
    
    class func getLastPrices(completion: @escaping (_ status: CryptoNetworkResult) -> Void) {
        let request = Request(urlString: ServiceDefinitions.lastPrices)
        request.onBaseCallback = completion
        ServicesRequest.callService(with: request)
    }
}
