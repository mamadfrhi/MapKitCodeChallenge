//
//  WaitingViewModel.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import Foundation


class WaitingVM: WaitingViewModelType {
    
    // MARK: Properties
    private weak var appServices: Serviceable?
    // delegates
    var appCoordinatorDelegate: AppCoordinatorDelegate?
    var viewDelegate: WaitingViewModelViewDelegate?
    
    var cars : [Car]? {
        didSet {
            if let cars = cars {
                DispatchQueue.main.async {
                    self.appCoordinatorDelegate?.dataReceived(cars: cars)
                }
            }
        }
    }
    
    //MARK: Waiting VM
    init(service: Serviceable) { self.appServices = service }
    
    func start() { fetch() }
}

// MARK: Network
extension WaitingVM {
    func fetch() {
        appServices?.fetchCars {
            [weak self]
            (cars, error) in
            guard let sSelf = self else { return }
            
            // failure
            if let error = error {
                let errorMessage = error.localizedDescription
                sSelf.ShowError(with: errorMessage)
                return
            }
            
            if let cars = cars as? [Car] {
                // success
                sSelf.cars = cars
            }else {
                // failure
                sSelf.ShowError(with: CarsAPIError.noData.localizedDescription)
            }
        }
    }
    
    private func ShowError(with errorMessage: String) {
        DispatchQueue.main.async {
            self.viewDelegate?.showError(text: errorMessage)
        }
    }
    
    func retry() { start() }
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
