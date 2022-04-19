//
//  WaitingViewModel.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import Foundation


class WaitingVM  {
    
    // MARK: Properties
    private weak var appServices: Serviceable?
    // delegates
    var appCoordinatorDelegate: AppCoordinatorDelegate?
    var viewDelegate: WaitingViewModelViewDelegate?
    
    private var carViewDatas : [CarViewData]? {
        didSet {
            DispatchQueue.main.async {
                self.appCoordinatorDelegate?.dataReceived(carViewDatas: self.carViewDatas!)
            }
        }
    }
    
    //MARK: Waiting VM
    init(service: Serviceable) { self.appServices = service }
    
    func start() { fetch() }
}

// MARK: Network
extension WaitingVM: WaitingViewModelType {
    func fetch() {
        appServices?.fetchCars {
            [weak self]
            (cars, error) in
            guard let sSelf = self else { return }
            
            // failure
            if let error = error {
                let errorMessage = error.localizedDescription
                sSelf.showError(with: errorMessage)
                return
            }
            
            if let cars = cars as? [Car] {
                // success
                sSelf.carViewDatas = cars.compactMap { CarViewData(car: $0) }
            }else {
                // failure
                sSelf.showError(with: CarsAPIError.noData.localizedDescription)
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
    func dataReceived(carViewDatas: [CarViewData])
}

// MARK: - ViewModelViewDelegate
protocol WaitingViewModelViewDelegate {
    func showError(text: String)
    func hideError()
}
