//
//  MapCarsCoordinator.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit
import MapKit

class MapCarsCoordinator: Coordinator {
    
    // MARK: Properties
    private weak var rootTabBarController: UITabBarController! // write a test for it - Must be injected
    private var mapCarsNavigationContrller = UINavigationController()
    
    private let mapCarsStoryboard = UIStoryboard(name: "MapCars", bundle: nil)
    
    // MARK: VM
    private var cars: [Car]
    private var mapCarsVM: MapCarsVM {
        let mapCarsVM = MapCarsVM(cars: self.cars)
        mapCarsVM.mapCarsCoordinatorDelegate = self
        return mapCarsVM
    }
    
    
    // MARK: Coordinator
    init(rootTabBarController: UITabBarController, cars: [Car]) {
        self.cars = cars
        super.init()
        self.rootTabBarController = rootTabBarController
    }
    
    override func start() {
        let mapCarsVC = `init_MapCarVC`(mapCarsVM: mapCarsVM)! // take care of force unwrapping
        let tabBar = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        tabBar.badgeValue = "\(cars.count)"
        mapCarsVC.tabBarItem = tabBar
        
        mapCarsNavigationContrller.setViewControllers([mapCarsVC], animated: true)
        rootTabBarController.setViewControllers([mapCarsNavigationContrller], animated: true)
    }
}

// MARK: - ViewModel Callbacks
extension MapCarsCoordinator: MapCarsViewModelCoordinatorDelegate {
    func didSelect(_ annotationView: MKAnnotationView, from mapView: MKMapView) {
        guard let carAnnotationView = annotationView as? CarAnnotationView,
              let carData = carAnnotationView.carData else { return }
        showCarInfo(of: carData)
    }
}

//MARK: Navigation
extension MapCarsCoordinator {
    private func showCarInfo(of car: Car) { // it shows a modal page
        let carInfoSB = UIStoryboard.init(name: "CarInfo", bundle: nil)
        let carInfoVC = carInfoSB.instantiateViewController(withIdentifier: "CarInfoVC") as! CarInfoVC
        carInfoVC.car = car
        mapCarsNavigationContrller.present(carInfoVC,
                                           animated: true, completion: nil)
    }
}
