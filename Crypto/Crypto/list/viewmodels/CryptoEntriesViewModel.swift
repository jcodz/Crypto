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
        var matchedList: [CryptoEntryDto] = []
        
        for crypto in cryptos {
            if let index = lastPrices.firstIndex(where: { $0.book ==  crypto.book }) {
                matchedList.append(lastPrices[index])
            }
        }
        
        return matchedList
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
            case .success(let data):
                
                guard let entries = CryptoParser<CryptoEntriesDto>.parse(from: data) else {
                    self?.delegate?.fetchFinishWithError(error: .defaultError)
                    return
                }
                
                self?.cryptos = entries.payload
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
            case .success(let data):
                
                guard let entries = CryptoParser<CryptoEntriesDto>.parse(from: data) else {
                    self?.delegate?.fetchFinishWithError(error: .defaultError)
                    return
                }
                
                self?.lastPrices = entries.payload
            case .failure(let error):
                self?.delegate?.fetchFinishWithError(error: error)
            }
            
            self?.group.leave()
        }
    }
}
