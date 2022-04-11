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
    private func retry() {
        viewModel.retry()
    }
}

// MARK: - ViewModel Delegate
extension WaitingVC: WaitingViewModelViewDelegate {
    func showError(text: String) {
        
    }
    
    func animate(_ flag: Bool) {
        print("you should \(flag)")
    }
    
    
}
