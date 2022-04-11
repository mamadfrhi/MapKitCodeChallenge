//
//  AppCoordinator.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit

// TODO: Add child coordinators as well
final class AppCoordinator: Coordinator { // TabCoordinator
    
    // MARK: Properties
    let window: UIWindow?
    
    var rootTabBarController = UITabBarController()
    
    // MARK: Child Coordinators
    var mapCarsCoordinator: Coordinator?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    let tabController = UITabBarController()
    
    func makeTabBar() -> UITabBarController {
        var controllers: [UIViewController] = []
        
        // in Coordinator
        let mapCarsStoryboard = UIStoryboard(name: "MapCars", bundle: nil)
        let mapCarsVC: MapCarsVC = mapCarsStoryboard.instantiateViewController(withIdentifier: "MapCarsVC") as! MapCarsVC
        mapCarsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        
        let listCarsStoryboard = UIStoryboard(name: "ListCars", bundle: nil)
        let listCarsVC: ListCarsVC = listCarsStoryboard.instantiateViewController(withIdentifier: "ListCarsVC") as! ListCarsVC
        listCarsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        
        controllers.append(mapCarsVC)
        controllers.append(listCarsVC)
        
        tabController.viewControllers = controllers
         
        return tabController
    }
    
    override func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootTabBarController
        window.makeKeyAndVisible()
        
        // first tab
        let mapCarsCoordinator = MapCarsCoordinator(rootTabBarController: rootTabBarController)
        mapCarsCoordinator.start()
        
        // second tab
        let listCarsCoordinator = ListCarsCoordinator(rootTabBarController: rootTabBarController)
        listCarsCoordinator.start()
    }
}
