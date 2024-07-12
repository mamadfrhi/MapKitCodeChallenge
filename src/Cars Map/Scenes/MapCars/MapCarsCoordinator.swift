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
    private weak var rootTabBarController: UITabBarController!
    private let mapCarsNavigationContrller = UINavigationController()
    
    // MARK: VM
    private let carViewDatas: [CarViewData]
    private var mapCarsVM: MapCarsVM {
        let mapCarsVM = MapCarsVM(carViewDatas: self.carViewDatas)
        mapCarsVM.mapCarsCoordinatorDelegate = self
        return mapCarsVM
    }
    
    
    // MARK: Coordinator
    init(rootTabBarController: UITabBarController, carViewDatas: [CarViewData]) {
        self.carViewDatas = carViewDatas
        self.rootTabBarController = rootTabBarController
    }
    
    override func start() {
        
        let mapCarsVC = MapCarsVC.`init`(mapCarsVM: mapCarsVM)
        let tabBar = UITabBarItem(title: "Map", image: UIImage(named: "map"), tag: 0)
        tabBar.badgeValue = "\(carViewDatas.count)"
        mapCarsVC.tabBarItem = tabBar
        
        mapCarsNavigationContrller.setViewControllers([mapCarsVC], animated: true)
        rootTabBarController.setViewControllers([mapCarsNavigationContrller], animated: true)
    }
}

// MARK: - ViewModel Callbacks
extension MapCarsCoordinator: MapCarsViewModelCoordinatorDelegate {
    func didSelect(_ annotationView: MKAnnotationView, from mapView: MKMapView) {
        guard let carAnnotationView = annotationView as? CarAnnotationView else { return }
        let carViewData = carAnnotationView.carViewData
        showCarInfo(of: carViewData)
    }
}

//MARK: Navigation
extension MapCarsCoordinator {
    private func showCarInfo(of carViewData: CarViewData) { // it shows a modal page
        let carInfoSB = UIStoryboard.init(name: "CarInfo", bundle: nil) // make a factory pattern for this class as well
        let carInfoVC = carInfoSB.instantiateViewController(withIdentifier: "CarInfoVC") as! CarInfoVC
        carInfoVC.carViewData = carViewData
        mapCarsNavigationContrller.present(carInfoVC,
                                           animated: true, completion: nil)
    }
}
