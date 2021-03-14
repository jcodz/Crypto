//
//  CryptoEntriesViewModel.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

class CryptoEntriesViewModel {
    
    weak var delegate: CryptoEntriesDelegate?
    
    internal func fetchEntries() {
       
        APICrypto.getCryptos { result in
            switch result {
            case .success(let entries):
                self.delegate?.fetchFinishWithSuccess(entries: entries)
            case .failure(let error):
                self.delegate?.fetchFinishWithError(error: error)
            }
        }
        
    }
}
