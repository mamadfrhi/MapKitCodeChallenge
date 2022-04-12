//
//  CatsViewModel.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit
import MapKit

class MapCarsViewModel {
    
    // MARK: Delegates
    var mapCarsCoordinatorDelegate: MapCarsViewModelCoordinatorDelegate?
    var viewDelegate: MapCarsViewModelViewDelegate?
    
    // MARK: Properties
    var cars: [Car] = []
    
    // MARK: Init
    init() {}
    
    func start() {
        // convert to viewType
        var carAnnotations: [MKPointAnnotation] = []
        for car in cars {
            let carAnnotation = CarViewData(car: car).coordinate
            carAnnotations.append(carAnnotation)
        }
        // call VC
        viewDelegate?.refreshScreen(with: carAnnotations)
    }
    
}

// Implement interface below for MapVM


//// MARK: - ViewModelType
//extension CatsViewModel: CatsViewModelType {
//
//    func numberOfItems() -> Int {
//        return cats.count
//    }
//
//    func itemFor(row: Int) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "catID")
//        let catViewData = CatViewData(cat: cats[row])
//        cell.textLabel?.text = catViewData._id
//        cell.detailTextLabel?.text = catViewData.createdAt
//        return cell
//    }
//
//    func add() {
//        getNewCat()
//        viewDelegate?.updateScreen()
//    }
//
//    func delete() {
//        let row = self.viewDelegate?.selectedCatRow()
//        self.remove(at: row)
//    }
//
//    func didSelectRow(_ row: Int, from controller: UIViewController) {
//        print("Cat in \(row) selected")
//        didSelect(cat: cats[row], from: controller)
//    }
//
//    func refreshView() {
//        start() // to refresh arrays
//        viewDelegate?.updateScreen()
//    }
//}

// MARK: - ViewModelCoordinator
extension MapCarsViewModel: MapCarsViewModelCoordinatorDelegate {
    func didSelect(car: Car, from controller: UIViewController) {
        mapCarsCoordinatorDelegate?.didSelect(car: car,
                                              from: controller)
        // It'll open CarsDetail VC
    }
}
