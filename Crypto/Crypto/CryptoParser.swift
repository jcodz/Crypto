//
//  CryptoParser.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

class CryptoParser<T: Decodable> {
    
    static func parse(from data: Data) -> T? {
        let decoder = JSONDecoder()
        let response = try? decoder.decode(T.self, from: data)
        return response
    }
}
