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
    
    private let rootTabBarController = UITabBarController()
    
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
    private func startTabBarControllers(with carViewDatas: [CarViewData]) {
        
        configAppAppearance()
        // first tab
        let mapCarsCoordinator = MapCarsCoordinator(rootTabBarController: rootTabBarController,
                                                    carViewDatas: carViewDatas)
        self.addChildCoordinator(mapCarsCoordinator)
        mapCarsCoordinator.start()
        
        // second tab
        let listCarsCoordinator = ListCarsCoordinator(rootTabBarController: rootTabBarController,
                                                      carViewDatas: carViewDatas)
        self.addChildCoordinator(listCarsCoordinator)
        listCarsCoordinator.start()
    }
    
    private func startWaitingVC() {
        let waitingVM = WaitingVM(service: services)
        let waitingVC = WaitingVC.`init`(waitingVM: waitingVM)
        waitingVM.appCoordinatorDelegate = self
        window?.rootViewController = waitingVC
    }
}

//MARK: View Configs
extension AppCoordinator {
    
    private func configAppAppearance() {
        configTabBarAppearance()
        configNavigationBarAppearance()
    }
    
    private func configTabBarAppearance() {
        rootTabBarController.tabBar.barTintColor = UIColor(named: "sixt_black")
        rootTabBarController.tabBar.tintColor = UIColor(named: "sixt_orange")
        UINavigationBar.appearance().barTintColor = UIColor(named: "sixt_black")
    }
    
    private func configNavigationBarAppearance() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
    }
}

// MARK: AppCoordinator Delegate
extension AppCoordinator: AppCoordinatorDelegate{
    func dataReceived(carViewDatas: [CarViewData]) {
        print("\nI'm in AppCoordinator and received \(carViewDatas.count) cars.")
        // close WaitingVC
        self.window?.rootViewController = rootTabBarController
        // start tabbars
        startTabBarControllers(with: carViewDatas)
    }
}
