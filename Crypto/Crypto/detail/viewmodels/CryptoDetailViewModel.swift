//
//  CryptoDetailViewModel.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import Foundation

class CryptoDetailViewModel {
    
    weak var delegate: CryptoDetailDelegate?
    
    func fetchDetail(with bookId: String) {
        APICrypto.getCrypto(bookId: bookId) { [weak self] result in
            switch result {
            case .success(let data):
                
                guard let book = CryptoParser<CryptoDetailDto>.parse(from: data) else {
                    self?.delegate?.fetchFinishWithError(error: .defaultError)
                    return
                }
                
                self?.delegate?.fetchFinishWithSuccess(book: book.payload)
                
            case .failure(let error):
                self?.delegate?.fetchFinishWithError(error: error)
            }
        }
    }
}
