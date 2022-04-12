//
//  ListCarsCoordinator.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit

class ListCarsCoordinator: Coordinator {
    
    // MARK: Properties
    private weak var rootTabBarController: UITabBarController! // write a test for it - Must be injected
    private var listCarsNavigationContrller = UINavigationController()
    
    private let listCarsStoryboard = UIStoryboard(name: "ListCars", bundle: nil)

    // MARK: VM
    private var cars: [Car]
    private var listCarsVM: ListCarsVM {
        let listCarsVM = ListCarsVM()
        listCarsVM.listCarsCoordinatorDelegate = self
        listCarsVM.cars = self.cars
        return listCarsVM
    }
    
    // MARK: Coordinator
    init(rootTabBarController: UITabBarController, cars: [Car]) {
        // set ListCarsVC to root VC
        self.cars = cars
        super.init()
        self.rootTabBarController = rootTabBarController
    }
    
    override func start() {
        let listCarsVC = listCarsStoryboard.instantiateViewController(withIdentifier: "ListCarsVC") as! ListCarsVC
        listCarsVC.viewModel = listCarsVM
        listCarsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 1)
        
        listCarsNavigationContrller.setViewControllers([listCarsVC], animated: true)
        rootTabBarController.viewControllers?.append(listCarsNavigationContrller)
        // it appends to the previously set VC(tab) - in this case - MapCarsVC
        // write a test to check order of the tabs!
    }
}

// MARK: - ViewModel Callbacks
extension ListCarsCoordinator: ListCarsViewModelCoordinatorDelegate {
    func didSelect(car: Car, from controller: UIViewController) {
        print("I'm in ListCarsCoordinator and received a car using MapCarsVMDelegate")
        showCarInfo(of: car)
    }
}

//MARK: Navigation
extension ListCarsCoordinator {
    private func showCarInfo(of car: Car) { // it shows a modal page
        let carInfoSB = UIStoryboard.init(name: "CarInfo", bundle: nil)
        let carInfoVC = carInfoSB.instantiateViewController(withIdentifier: "CarInfoVC") as! CarInfoVC
        carInfoVC.car = car
        listCarsNavigationContrller.present(carInfoVC,
                                            animated: true, completion: nil)
    }
}
