//
//  CryptoEntriesViewModel.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

class CryptoEntriesViewModel {
    
    private let group = DispatchGroup()
    private var cryptos: [CryptoEntryDto] = []
    private var lastPrices: [CryptoEntryDto] = []
    
    var datasource: [CryptoEntryDto] {
        var mergedList: [CryptoEntryDto] = []
        
        for crypto in cryptos {
            for lastPrice in lastPrices {
                if crypto.book == lastPrice.book {
                    mergedList.append(lastPrice)
                }
            }
        }
        
        return mergedList
    }
    
    
    weak var delegate: CryptoEntriesDelegate?
    
    func fetchEntries() {
        
        getCryptos()
        getLastPrices()
        
        group.notify(queue: .main) {
            self.delegate?.fetchFinishWithSuccess(entries: self.datasource)
        }
    }
    
    private func getCryptos() {
        group.enter()
        
        APICrypto.getCryptos { [weak self] result in
            switch result {
            case .success(let entries):
                self?.cryptos = entries
            case .failure(let error):
                self?.delegate?.fetchFinishWithError(error: error)
            }
            
            self?.group.leave()
        }
    }
    
    private func getLastPrices() {
        group.enter()
        
        APICrypto.getLastPrices { [weak self] result in
            switch result {
            case .success(let entries):
                self?.lastPrices = entries
            case .failure(let error):
                self?.delegate?.fetchFinishWithError(error: error)
            }
            
            self?.group.leave()
        }
    }
}
