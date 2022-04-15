//
//  ListCarsCoordinator.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit

class ListCarsCoordinator: Coordinator {
    
    // MARK: Properties
    private weak var rootTabBarController: UITabBarController!
    private let listCarsNavigationContrller = UINavigationController()
    
    // MARK: VM
    private let cars: [Car]
    private var listCarsVM: ListCarsVM {
        let listCarsVM = ListCarsVM(cars: cars)
        listCarsVM.listCarsCoordinatorDelegate = self
        return listCarsVM
    }
    
    // MARK: Coordinator
    init(rootTabBarController: UITabBarController, cars: [Car]) {
        self.rootTabBarController = rootTabBarController
        self.cars = cars
    }
    
    override func start() {
        
        let listCarsVC = ListCarsVC.`init`(listCarsVM: listCarsVM)
        let tabBar = UITabBarItem(title: "List", image: UIImage(named: "list"), tag: 0)
        listCarsVC.tabBarItem = tabBar
        
        listCarsNavigationContrller.setViewControllers([listCarsVC], animated: true)
        rootTabBarController.viewControllers?.append(listCarsNavigationContrller)
        // why append? it appends to the previously set VC(tab) - in this case - MapCarsVC
    }
}

// MARK: - ViewModel Callbacks
extension ListCarsCoordinator: ListCarsViewModelCoordinatorDelegate {
    func didSelect(car: Car, from controller: UIViewController) {
        showCarInfo(of: car)
    }
}

//MARK: Navigation
extension ListCarsCoordinator {
    private func showCarInfo(of car: Car) { // it shows a modal page
        let carInfoSB = UIStoryboard.init(name: "CarInfo", bundle: nil)
        let carInfoVC = carInfoSB.instantiateViewController(withIdentifier: "CarInfoVC") as! CarInfoVC
        carInfoVC.car = car
        listCarsNavigationContrller.present(carInfoVC, animated: true, completion: nil)
    }
}
