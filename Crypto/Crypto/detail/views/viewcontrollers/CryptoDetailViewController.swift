//
//  CryptoDetailViewController.swift
//  Crypto
//
//  Created by Juan Cruz Ortiz de Zarate on 14/03/2021.
//

import UIKit

class CryptoDetailViewController: UIViewController {
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var bidLabel: UILabel!
    @IBOutlet private weak var askLabel: UILabel!
    @IBOutlet private weak var lowLabel: UILabel!
    @IBOutlet private weak var highLabel: UILabel!
    @IBOutlet private weak var volumeLabel: UILabel!
    
    private var viewModel: CryptoDetailViewModel!
    private var timer = Timer()
    
    var bookId: String?
    
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
        timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.fetchDetail), userInfo: nil, repeats: true)
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
