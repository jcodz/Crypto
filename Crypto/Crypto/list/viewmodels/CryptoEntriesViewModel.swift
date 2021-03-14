//
//  CryptoEntriesViewModel.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

class CryptoEntriesViewModel {
    
    var datasource: [CryptoEntryDto] = []
    weak var delegate: CryptoEntriesDelegate?
    
    func fetchEntries() {
        APICrypto.getCryptos { [weak self] result in
            switch result {
            case .success(let data):
                
                guard let entries = CryptoParser<CryptoEntriesDto>.parse(from: data) else {
                    self?.delegate?.fetchFinishWithError(error: .defaultError)
                    return
                }
                
                self?.datasource = entries.payload
                self?.getLastPrices()
            case .failure(let error):
                self?.delegate?.fetchFinishWithError(error: error)
            }
        }
    }
    
    private func getLastPrices() {
        APICrypto.getLastPrices { [weak self] result in
            switch result {
            case .success(let data):
                
                guard let entries = CryptoParser<CryptoEntriesDto>.parse(from: data) else {
                    self?.delegate?.fetchFinishWithError(error: .defaultError)
                    return
                }
                
                self?.update(with: entries.payload)
                self?.delegate?.fetchFinishWithSuccess(entries: self?.datasource ?? [])
            case .failure(let error):
                self?.delegate?.fetchFinishWithError(error: error)
            }
        }
    }
    
    private func update(with lastPrices: [CryptoEntryDto]) {
        for (cryptoIndex, crypto) in datasource.enumerated() {
            if let lastPricesIndex = lastPrices.firstIndex(where: { $0.book ==  crypto.book }) {
                datasource[cryptoIndex].last = lastPrices[lastPricesIndex].last
            }
        }
    }
}
