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
            if let cars = cars {
                DispatchQueue.main.async {
                    // because it's called from background thread
                    // and coordinatorDelegate will have view related functinos
                    self.appCoordinatorDelegate?.dataReceived(cars: cars)
                }
            }
        }
    }
    
    //MARK: Waiting VM
    init(apiClient: Network) {
        self.apiClient = apiClient
    }
    
    func start() {
        fetch()
    }
}

// MARK: Network
extension WaitingViewModel {
    func fetch() {
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
                        sSelf.viewDelegate?.showError(text: CarsAPIError.noData.localizedDescription)
                    }
                }
            case .failure(let error):
                let errorMessage = error.localizedDescription
                DispatchQueue.main.async {
                    sSelf.viewDelegate?.showError(text: errorMessage)
                }
            }
        }
    }
    
    func retry() {
        fetch()
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
