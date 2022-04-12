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
        let mapCarsVM = MapCarsVM()
        mapCarsVM.mapCarsCoordinatorDelegate = self
        mapCarsVM.cars = self.cars
        return mapCarsVM
    }
    
    
    // MARK: Coordinator
    init(rootTabBarController: UITabBarController, cars: [Car]) {
        // set MapCarsVC to root VC
        self.cars = cars
        super.init()
        self.rootTabBarController = rootTabBarController
        self.start()
    }
    
    override func start() {
        let mapCarsVC = mapCarsStoryboard.instantiateViewController(withIdentifier: "MapCarsVC") as! MapCarsVC
        mapCarsVC.viewModel = mapCarsVM
        mapCarsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        
        mapCarsNavigationContrller.setViewControllers([mapCarsVC], animated: true)
        rootTabBarController.setViewControllers([mapCarsNavigationContrller], animated: true)
    }
}

// MARK: - ViewModel Callbacks
extension MapCarsCoordinator: MapCarsViewModelCoordinatorDelegate {
    func didSelect(_ annotationView: MKAnnotationView, from mapView: MKMapView) {
        // TODO: Find a wat to write codes below in the VM
        guard let carAnnotationView = annotationView as? CarAnnotationView,
              let carData = carAnnotationView.carData else { return }
        // it's a custom car data annotation which contains CarData too!
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
