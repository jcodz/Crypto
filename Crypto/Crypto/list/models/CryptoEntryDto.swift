//
//  CryptoEntryDto.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

struct CryptoEntriesDto: Decodable {
    let payload: [CryptoEntryDto]
}

struct CryptoEntryDto: Decodable {
    let book: String
    let last: String?
    let volume: String?
    let high: String?
    let low: String?
    let ask: String?
    let bid: String?
}
