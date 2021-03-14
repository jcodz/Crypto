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
    
    private let refreshControl = UIRefreshControl()
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
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl // iOS 10+
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        self.viewModel.fetchEntries()
        showSpinner()
        refreshControl.endRefreshing()
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.edgesForExtendedLayout = []
        self.title = "Books"
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
        let alert = UIAlertController(title: "Error", message: "There was an internal error", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CryptoEntriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "CryptoDetail") as? CryptoDetailViewController else { return }
        detailVC.bookId = viewModel.datasource[indexPath.row].book
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
