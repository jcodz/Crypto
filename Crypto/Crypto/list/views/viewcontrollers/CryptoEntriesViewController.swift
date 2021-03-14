//
//  CryptoEntriesViewController.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import UIKit

class CryptoEntriesViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    
    private var viewModel: CryptoEntriesViewModel!
    
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
    
    private func showSpinner() {
        loader.startAnimating()
    }
    
    private func hideSpinner() {
        loader.stopAnimating()
    }
}

extension CryptoEntriesViewController: CryptoEntriesDelegate {
    func fetchFinishWithSuccess(entries: [CryptoEntryDto]) {
        DispatchQueue.main.async {
            self.hideSpinner()
            self.collectionView.reloadData()
        }
    }
    
    func fetchFinishWithError(error: CryptoNetworkResult.CryptoNetworkError) {
        //Show alert
    }
}

extension CryptoEntriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EntryCell.cellId, for: indexPath) as? EntryCell else { return UICollectionViewCell() }
        
        cell.configure(with: viewModel.datasource[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}

extension CryptoEntriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(CryptoDetailViewController(), animated: true)
    }
}
