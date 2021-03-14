//
//  CryptoDetailViewController.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import UIKit

class CryptoDetailViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var bidLabel: UILabel!
    @IBOutlet private weak var askLabel: UILabel!
    @IBOutlet private weak var lowLabel: UILabel!
    @IBOutlet private weak var highLabel: UILabel!
    @IBOutlet private weak var volumeLabel: UILabel!
    @IBOutlet private weak var booksBanner: UICollectionView!
    
    private var viewModel: CryptoDetailViewModel!
    private var autoRefreshTimer = Timer()
    private var autoScrollTimer = Timer()
    private let loops = 1000
    
    var bookId: String?
    var availableBooks: [CryptoEntryDto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        showSpinner()
        fetchDetail()
        setAutoRefresh()
    }
    
    private func setup() {
        setupNavigation()
        setupViewModel()
        setupCollection()
        setupAutoscrollableBanner()
    }
    
    private func setupViewModel() {
        self.viewModel = CryptoDetailViewModel()
        self.viewModel?.delegate = self
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.edgesForExtendedLayout = []
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollection() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        collectionView.register(BookBannerCell.self, forCellWithReuseIdentifier: BookBannerCell.cellId)
    }
    
    private func setupAutoscrollableBanner() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(self.autoscroll), userInfo: nil, repeats: true)
    }
    
    @objc private func autoscroll() {
        self.collectionView.contentOffset.x += 0.5
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func showSpinner() {
        loader.startAnimating()
    }
    
    private func hideSpinner() {
        loader.stopAnimating()
    }
    
    @objc private func fetchDetail() {
        self.viewModel.fetchDetail(with: self.bookId ?? "")
    }
    
    private func setAutoRefresh() {
        autoRefreshTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.fetchDetail), userInfo: nil, repeats: true)
    }
}

extension CryptoDetailViewController: CryptoDetailDelegate {
    func fetchFinishWithSuccess(book: CryptoEntryDto) {
        DispatchQueue.main.async {
            self.title = book.book
            self.bidLabel.text = book.bid
            self.askLabel.text = book.ask
            self.lowLabel.text = book.low
            self.highLabel.text = book.high
            self.volumeLabel.text = book.volume
            self.hideSpinner()
        }
    }
    
    func fetchFinishWithError(error: CryptoNetworkResult.CryptoNetworkError) {
        let alert = UIAlertController(title: "Error", message: "There was an internal error", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
}

extension CryptoDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableBooks.count * loops
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookBannerCell.cellId, for: indexPath) as? BookBannerCell else { return UICollectionViewCell() }
        
        cell.configure(with: availableBooks[indexPath.row % availableBooks.count])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
