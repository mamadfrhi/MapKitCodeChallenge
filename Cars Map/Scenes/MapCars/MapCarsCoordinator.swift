//
//  MapCarsCoordinator.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit

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

extension MapCarsCoordinator: MapCarsViewModelCoordinatorDelegate {
    func didSelect(car: Car, from controller: UIViewController) {
        print("I'm in MapCarsCoordinator and received a car using MapCarsVMDelegate")
    }
}
