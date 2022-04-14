//
//  Cars_MapTests.swift
//  Cars MapTests
//
//  Created by iMamad on 4/13/22.
//

import XCTest
@testable import Cars_Map

class Cars_MapTests: XCTestCase {
    
}

// MARK: TabController tests
extension Cars_MapTests {
    func testVCTitles() {
        // prepare
        let data = self.makeRootTabBarAndGive()
        let rootTabBarController = data.0
        let cars = data.1
        
        // first tab
        let mapCarsCoordinator = MapCarsCoordinator(rootTabBarController: rootTabBarController,
                                                    cars: cars)
        mapCarsCoordinator.start()
        
        // second tab
        let listCarsCoordinator = ListCarsCoordinator(rootTabBarController: rootTabBarController,
                                                      cars: cars)
        listCarsCoordinator.start()
        
        // reach 1st tab
        let mapNav = rootTabBarController.viewControllers?[0] as? UINavigationController
        let mapVC = mapNav?.viewControllers.first
        let mapTitle = mapVC?.title
        XCTAssertEqual(mapTitle, "Map")
        
        // reach 2nd tab
        let listNav = rootTabBarController.viewControllers?[1] as? UINavigationController
        let listVC = listNav?.viewControllers.first
        let listTitle = listVC?.title
        XCTAssertEqual(listTitle, "List")
        
        
        // test badge
        // violates SRP
        let badgeValue = mapVC!.tabBarItem.badgeValue!
        let carsCount = "\(cars.count)"
        XCTAssertEqual(badgeValue, carsCount)
    }
    
    func makeRootTabBarAndGive() -> (UITabBarController, [Car]) {
        // preapring tab controller
        let cars = makeCars()
        let _ = makeMapCarsVC(mapCarsViewModel: MapCarsVM(cars: cars))
        return (UITabBarController(), cars)
    }
}

// MARK: helpers
extension Cars_MapTests {
    func makeCars() -> [Car] {
        let car2 = Car(id: "WBAUE51070P352494",
                       modelName: "BMW 1er",
                       name: "Lasse",
                       make: "BMW",
                       color: "saphirschwarz",
                       fuelLevel: 0.92,
                       latitude: 48.170041,
                       longitude: 11.576643,
                       carImageUrl: "https://cdn.sixt.io/codingtask/images/bmw_1er.png")

        let car1 = Car(id: "WMWSW31030T222518",
                       modelName: "MINI",
                       name: "Vanessa",
                       make: "BMW",
                       color: "midnight_black",
                       fuelLevel: 0.7,
                       latitude: 48.134557,
                       longitude: 11.576921,
                       carImageUrl: "https://cdn.sixt.io/codingtask/images/mini.png")
        return [car1, car2]
    }

    func makeMapCarsVC(mapCarsViewModel: MapCarsVM) -> MapCarsVC {
        let catsStoryboard = UIStoryboard(name: "MapCars", bundle: nil)
        let mapCarsVC: MapCarsVC = catsStoryboard.instantiateViewController(withIdentifier: "MapCarsVC") as! MapCarsVC
        mapCarsVC.viewModel = mapCarsViewModel
        // Trigger view load and viewDidLoad()
        _ = mapCarsVC.view
        return mapCarsVC
    }
}
