//
//  WaitingVC.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit

class WaitingVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var acitivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    
    // MARK: Properties
    var viewModel: WaitingViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
    }
    
    // MARK: Setup
    
    // MARK: Actions
    @IBAction func retry(_ sender: Any) {
        viewModel.retry()
        self.hideError()
    }
}

// MARK: - ViewModel Delegate
extension WaitingVC: WaitingViewModelViewDelegate {
    func showError(text: String) {
        self.infoLabel.text = text + " ☹️"
        self.acitivityIndicator.isHidden = true
        self.retryBtn.isHidden = false
    }
    
    func hideError() {
        self.infoLabel.text = "I'm calling the server, please give me a sec!\n\n📞🌍☺️"
        self.acitivityIndicator.isHidden = false
        self.retryBtn.isHidden = true
    }
}
