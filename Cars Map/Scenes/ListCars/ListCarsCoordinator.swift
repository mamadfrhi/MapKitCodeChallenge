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
    
//    private let apiClient: Network
    
    // MARK: VM
    
    
    // MARK: Coordinator
    
    init(rootTabBarController: UITabBarController) {
        // set MapCarsVC to root VC
        
        let listCarsVC = listCarsStoryboard.instantiateViewController(withIdentifier: "ListCarsVC") as! ListCarsVC
        listCarsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1) // write a test to check if the tab sequences are correct
        
        listCarsNavigationContrller.setViewControllers([listCarsVC], animated: true)
        rootTabBarController.viewControllers?.append(listCarsNavigationContrller)
    }
    
    override func start() {
        print("I'm in ListCarsCoordinator")
    }
}
