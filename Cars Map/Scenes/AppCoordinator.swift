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
    private let window: UIWindow?
    
    private var rootTabBarController = UITabBarController()
    
    private var apiClient: Network = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json; charset=utf-8"]
        let apiClient = ApiClient(configuration: configuration)
        return apiClient
    }()
    
    // MARK: Child Coordinators
    private weak var mapCarsCoordinator: Coordinator?
    private weak var listCarsCoordinator: Coordinator?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
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
        let waitingStoryBoard = UIStoryboard.init(name: "Waiting", bundle: nil)
        let waitingVC = waitingStoryBoard.instantiateViewController(withIdentifier: "WaitingVC") as! WaitingVC
        let waitingVM = WaitingVM(apiClient: apiClient)
        waitingVM.appCoordinatorDelegate = self
        waitingVC.viewModel = waitingVM
        window?.rootViewController = waitingVC
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
