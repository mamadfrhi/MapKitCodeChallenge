//
//  WaitingVC.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit

class WaitingVC: UIViewController {
    
    // MARK: Outlets
    
    // MARK: Properties
    var viewModel: WaitingViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        print("WaitingVC loaded!")
        viewModel.start()
    }
    
    // MARK: Setup
    
    // MARK: Actions
}

// MARK: - ViewModel Delegate
extension WaitingVC: WaitingViewModelViewDelegate {
    func updateLabelWith(text: String) {
        print("Update error label to" + text)
    }
    
    func animate(_ flag: Bool) {
        print("you should \(flag)")
    }
    
    
}
