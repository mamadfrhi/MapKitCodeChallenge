//
//  CatsViewModel.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit
import MapKit

class ListCarsVM {
    
    // MARK: Delegates
    var listCarsCoordinatorDelegate: ListCarsViewModelCoordinatorDelegate?
    var viewDelegate: ListCarsViewModelViewDelegate?
    
    // MARK: Properties
    var cars: [Car] = []
    // check if it must be weak or not
    
    // MARK: Init
    init() {}
    
    func start() {}
}

// Implement interface below for MapVM


// MARK: - ViewModelType
extension ListCarsVM: ListCarsVMType {
    func numberOfItems() -> Int {
        cars.count
    }
    
    func itemFor(row: Int) -> UITableViewCell {
        let cell = UITableViewCell()
        let carViewData = CarViewData(car: cars[row])
        cell.textLabel?.text = carViewData.name
        return cell
    }
    
    func didSelectRow(_ row: Int, from controller: UIViewController) {
        print("row \(row) selected!")
        didSelect(car: cars[row], from: controller)
    }
    
    func refreshView() {
        viewDelegate?.refreshScreen(with: cars)
    }
    
    
}

// MARK: - ViewModelCoordinator
extension ListCarsVM: ListCarsViewModelCoordinatorDelegate {
    func didSelect(car: Car, from controller: UIViewController) {
        listCarsCoordinatorDelegate?.didSelect(car: car, from: controller)
    }
}
