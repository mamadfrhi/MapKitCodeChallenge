//
//  WaitingViewModel.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import Foundation


class WaitingViewModel: WaitingViewModelType {
    
    // MARK: Properties
    private let apiClient: Network
    // delegates
    var appCoordinatorDelegate: AppCoordinatorDelegate?
    var viewDelegate: WaitingViewModelViewDelegate?
    
    var cars : [Car]? {
        didSet {
            // I'm filled
            // call the tab bars
        }
    }
        
    //MARK: Waiting VM
    init(apiClient: Network) {
        self.apiClient = apiClient
        print("WaitingVM is running!")
    }
    
    func start() {
        fetch()
    }
}

extension WaitingViewModel {
    func fetch() {
        // 1. request
        apiClient.fetch {
            [weak self]
            (result) in
            guard let sSelf = self else { return }
            switch result {
            case .success(let cars):
                if let cars = cars as? [Car] {
                    sSelf.cars = cars
                }else {
                    DispatchQueue.main.async {
                        sSelf.viewDelegate?.showError(text: "Bad error")
                    }
                }
                
            // add to array
            // refresh view using delegate
            case .failure(let error):
                let errorMessage = error.localizedDescription
                sSelf.viewDelegate?.showError(text: errorMessage)
            }
        }
    }
    
    func retry() {
        // it should resend the request
        fetch()
        // update views
    }
}

// MARK: - ViewModelType
protocol WaitingViewModelType {
    func fetch()
    func retry()
}

// MARK: - ViewModelCoordinator(delegate)
protocol AppCoordinatorDelegate {
    func dataReceived(cars: [Car])
}

// MARK: - ViewModelViewDelegate
protocol WaitingViewModelViewDelegate {
    func showError(text: String)
    func hideError()
}
