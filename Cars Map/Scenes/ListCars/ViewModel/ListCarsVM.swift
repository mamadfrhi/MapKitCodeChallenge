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
    private var cars: [Car] = []
    // check if it must be weak or not
    
    // MARK: Init
    init(cars: [Car]) { self.cars = cars }
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
        didSelect(car: cars[row], from: controller)
    }
}

// MARK: - ViewModelCoordinator
extension ListCarsVM: ListCarsViewModelCoordinatorDelegate {
    func didSelect(car: Car, from controller: UIViewController) {
        listCarsCoordinatorDelegate?.didSelect(car: car, from: controller)
    }
}
