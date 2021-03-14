//
//  CryptoDetailDelegate.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

protocol CryptoDetailDelegate: AnyObject {
    func fetchFinishWithSuccess(book: CryptoEntryDto)
    func fetchFinishWithError(error: CryptoNetworkResult.CryptoNetworkError)
}
