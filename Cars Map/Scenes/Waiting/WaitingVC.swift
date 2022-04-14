//
//  WaitingVC.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit


class WaitingVC: UIViewController {
    
    //MARK: Factory
    class func `init`(waitingVM: WaitingVM) -> WaitingVC {
        let storyboard = UIStoryboard(name: "Waiting", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WaitingVC") as! WaitingVC
        // take care of force unwrapping above
        vc.viewModel = waitingVM
        return vc
    }
    
    // MARK: Outlets
    @IBOutlet weak var acitivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    
    // MARK: Properties
    var viewModel: WaitingVM! { // write a test to check that it must not get nil
        didSet { viewModel.viewDelegate = self }
    }
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
    }
    
    // MARK: Actions
    @IBAction func retry(_ sender: Any) {
        hideError()
        viewModel.retry()
    }
}

// MARK: - ViewModel Delegate
extension WaitingVC: WaitingViewModelViewDelegate {
    func showError(text: String) {
        infoLabel.text = text + " ☹️"
        acitivityIndicator.isHidden = true
        retryBtn.isHidden = false
    }
    
    func hideError() {
        infoLabel.text = "I'm calling the server, please give me a sec!\n\n📞🌍☺️"
        acitivityIndicator.isHidden = false
        retryBtn.isHidden = true
    }
}
