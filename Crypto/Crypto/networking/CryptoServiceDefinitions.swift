//
//  CryptoServiceDefinitions.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

class ServiceDefinitions {
    
    private static let domain = "https://api.bitso.com"
    
    static var availableBooks: String {
        return "\(ServiceDefinitions.domain)/v3/available_books/"
    }
    
    static var lastPrices: String {
        return "\(ServiceDefinitions.domain)/v3/ticker/"
    }
    
    static var book: String {
        return "\(ServiceDefinitions.domain)/v3/ticker/"
    }
}
