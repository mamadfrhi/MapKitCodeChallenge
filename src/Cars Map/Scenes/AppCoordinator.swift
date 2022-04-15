//
//  AppCoordinator.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit

final class AppCoordinator: Coordinator { // TabCoordinator
    
    // MARK: Properties
    private let window: UIWindow?
    
    private var rootTabBarController = UITabBarController()
    
    lazy private var apiClient: Network = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json; charset=utf-8"]
        let apiClient = ApiClient(configuration: configuration)
        return apiClient
    }()
    
    lazy private var services: Serviceable = {
        let services = AppServices(apiClient: apiClient)
        return services
    }()
    
    // MARK: Init
    init(window: UIWindow?) { self.window = window }
    
    override func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootTabBarController
        window.makeKeyAndVisible()
        
        startWaitingVC()
    }
}

// MARK: Starts
extension AppCoordinator {
    private func startTabBarControllers(with cars: [Car]) {
        
        configAppAppearance()
        // first tab
        let mapCarsCoordinator = MapCarsCoordinator(rootTabBarController: rootTabBarController,
                                                    cars: cars)
        self.addChildCoordinator(mapCarsCoordinator)
        mapCarsCoordinator.start()
        
        // second tab
        let listCarsCoordinator = ListCarsCoordinator(rootTabBarController: rootTabBarController,
                                                      cars: cars)
        self.addChildCoordinator(listCarsCoordinator)
        listCarsCoordinator.start()
    }
    
    private func startWaitingVC() {
        let waitingVM = WaitingVM(service: services)
        let waitingVC = WaitingVC.`init`(waitingVM: waitingVM)
        waitingVM.appCoordinatorDelegate = self
        waitingVC.viewModel = waitingVM
        window?.rootViewController = waitingVC
    }
}

//MARK: View Configs
extension AppCoordinator {
    private func configTabBarAppearance() {
        rootTabBarController.tabBar.barTintColor = UIColor(named: "sixt_black")
        rootTabBarController.tabBar.tintColor = UIColor(named: "sixt_orange")
        UINavigationBar.appearance().barTintColor = UIColor(named: "sixt_black")
    }
    
    private func configNavigationBarAppearance() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
    }
    
    private func configAppAppearance() {
        configTabBarAppearance()
        configNavigationBarAppearance()
    }
}

// MARK: AppCoordinator Delegate
extension AppCoordinator: AppCoordinatorDelegate{
    func dataReceived(cars: [Car]) {
        print("\nI'm in AppCoordinator and received \(cars.count) cars.")
        // close WaitingVC
        self.window?.rootViewController = rootTabBarController
        // start tabbars
        startTabBarControllers(with: cars)
    }
}
