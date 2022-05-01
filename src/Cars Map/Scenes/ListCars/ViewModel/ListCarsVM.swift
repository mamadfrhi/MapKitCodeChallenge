//
//  CatsViewModel.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit
import MapKit

// TIP: It's very thin VM
// so you can delete this VM
// and move the codes to VC

class ListCarsVM {
    
    // MARK: Delegates
    var listCarsCoordinatorDelegate: ListCarsViewModelCoordinatorDelegate?
    
    // MARK: Properties
    private let carViewDatas: [CarViewData]!
    // check if it must be weak or not
    
    // MARK: Init
    init(carViewDatas: [CarViewData]) { self.carViewDatas = carViewDatas }
}

// MARK: - ViewModelType
extension ListCarsVM: ListCarsVMType {
    func numberOfItems() -> Int {
        carViewDatas.count
    }
    
    func itemFor(row: Int) -> Any {
        return carViewDatas[row]
    }
    
    func didSelectRow(_ row: Int, from controller: UIViewController) {
        didSelect(carViewData: carViewDatas[row], from: controller)
    }
}

// MARK: - ViewModelCoordinator
extension ListCarsVM: ListCarsViewModelCoordinatorDelegate {
    func didSelect(carViewData: CarViewData, from controller: UIViewController) {
        listCarsCoordinatorDelegate?.didSelect(carViewData: carViewData, from: controller)
    }
}
