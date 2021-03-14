//
//  CryptoEntriesViewController.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import UIKit

class CryptoEntriesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: CryptoEntriesViewModel!
    private var datasource: [CryptoEntryDto] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.showSpinner()
        self.viewModel.fetchEntries()
    }
    
    private func setup() {
        self.setupNavigation()
        self.setupViewModel()
        self.setupCollection()
    }
    
    private func setupViewModel() {
        self.viewModel = CryptoEntriesViewModel()
        self.viewModel?.delegate = self
    }
    
    private func setupCollection() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        collectionView.register(EntryCell.self, forCellWithReuseIdentifier: EntryCell.cellId)
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.edgesForExtendedLayout = []
        
    }
    private func showSpinner() {}
    private func hideSpinner() {}
}

extension CryptoEntriesViewController: CryptoEntriesDelegate {
    func fetchFinishWithSuccess(entries: [CryptoEntryDto]) {
        self.datasource = entries
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.hideSpinner()
        }
    }
    
    func fetchFinishWithError(error: CryptoNetworkResult.CryptoNetworkError) {
        //Show alert
    }
}

extension CryptoEntriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EntryCell.cellId, for: indexPath) as? EntryCell else { return UICollectionViewCell() }
        
        cell.configure(with: datasource[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}

extension CryptoEntriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
