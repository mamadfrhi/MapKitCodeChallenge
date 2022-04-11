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
        apiClient.fetch { (result) in
            switch result {
            case .success(let cars):
                print(cars)
                // add to array
                // refresh view using delegate
            case .failure(let error):
                let errorMessage = error.localizedDescription
               // refresh view using delegate
            }
        }
        // 2. handle errors and show on label -> viewDelegate.
        // 3. give back data -> appCoordinatorDelegate
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
    func updateLabelWith(text: String)
    func animate(_:Bool)
}
