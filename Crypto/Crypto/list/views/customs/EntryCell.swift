//
//  EntryCell.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import UIKit

class EntryCell: UICollectionViewCell {
    
    static let cellId: String = "EntryCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    private lazy var lastPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lastPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lastPriceContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lastPriceTitleLabel)
        addSubview(lastPriceLabel)
        addSubview(container)
        return container
    }()
    
    private lazy var devider: UIView = {
        let devider = UIView()
        devider.translatesAutoresizingMaskIntoConstraints = false
        devider.backgroundColor = .gray
        addSubview(devider)
        return devider
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
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lastPriceTitleLabel.topAnchor.constraint(equalTo: lastPriceContainer.topAnchor),
            lastPriceTitleLabel.trailingAnchor.constraint(equalTo: lastPriceContainer.trailingAnchor),
            lastPriceTitleLabel.leadingAnchor.constraint(equalTo: lastPriceContainer.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            lastPriceLabel.topAnchor.constraint(equalTo: self.lastPriceTitleLabel.bottomAnchor, constant: 8),
            lastPriceLabel.trailingAnchor.constraint(equalTo: lastPriceContainer.trailingAnchor),
            lastPriceLabel.leadingAnchor.constraint(equalTo: lastPriceContainer.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            lastPriceContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            lastPriceContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            lastPriceContainer.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            devider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            devider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            devider.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            devider.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func configure(with cryptoModel: CryptoEntryDto) {
        self.titleLabel.text = cryptoModel.book
        self.lastPriceTitleLabel.text = "Last Price:"
        self.lastPriceLabel.text = cryptoModel.last
    }
}
