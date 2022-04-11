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
    
//    private let apiClient: Network
    
    // MARK: VM
    
    
    // MARK: Coordinator
    // inject VM and API
    init(rootTabBarController: UITabBarController) {
        // set MapCarsVC to root VC
        
        let mapCarsVC = mapCarsStoryboard.instantiateViewController(withIdentifier: "MapCarsVC") as! MapCarsVC
        mapCarsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        
        mapCarsNavigationContrller.setViewControllers([mapCarsVC], animated: true)
        rootTabBarController.setViewControllers([mapCarsNavigationContrller], animated: true)
    }
    
    override func start() {
        print("I'm in MapCarsCoordinator")
    }
}
