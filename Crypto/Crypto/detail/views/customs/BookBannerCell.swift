//
//  BookBannerCell.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import UIKit

class BookBannerCell: UICollectionViewCell {
    static let cellId: String = "BookBannerCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = ""
    }
    
    private func setupUI() {
        
        self.backgroundColor = .black
        self.titleLabel.textColor = .white
        self.priceLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
        ])
    }
    
    func configure(with cryptoModel: CryptoEntryDto) {
        self.titleLabel.text = cryptoModel.book
        self.priceLabel.text = cryptoModel.last
    }
}
