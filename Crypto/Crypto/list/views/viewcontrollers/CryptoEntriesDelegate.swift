//
//  CryptoEntriesDelegate.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

protocol CryptoEntriesDelegate: AnyObject {
    func fetchFinishWithSuccess(entries: [CryptoEntryDto])
    func fetchFinishWithError(error: CryptoNetworkResult.CryptoNetworkError)
}
