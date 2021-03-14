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
            devider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            devider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            devider.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            devider.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func configure(with cryptoModel: CryptoEntryDto) {
        self.titleLabel.text = cryptoModel.book
    }
}
