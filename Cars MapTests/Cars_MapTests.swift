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
    
    // TODO: test below violates SRP, cause it tests more than 1 thing (badges and titles etc.)
    // it'd be great to save rootTabBar and cars in test class
    // and then separate function test below to several functinos
    func testTabBarController() {
        
        // -- start tab tests --
        // - given -
        let rootTabBarController = UITabBarController()
        let cars = makeCars()
        
        // first tab
        let mapCarsCoordinator = MapCarsCoordinator(rootTabBarController: rootTabBarController,
                                                    cars: cars)
        mapCarsCoordinator.start()
        // second tab
        let listCarsCoordinator = ListCarsCoordinator(rootTabBarController: rootTabBarController,
                                                      cars: cars)
        listCarsCoordinator.start()
        
        // - when - 1st tab
        let mapNav = rootTabBarController.viewControllers?[0] as? UINavigationController
        let mapVC = mapNav?.viewControllers.first as? MapCarsVC
        let mapTitle = mapVC?.title
        // - then - 1st tab
        XCTAssertEqual(mapTitle, "Map")
        
        // - when - 2nd tab
        let listNav = rootTabBarController.viewControllers?[1] as? UINavigationController
        let listVC = listNav?.viewControllers.first as? ListCarsVC
        let listTitle = listVC?.title
        // - then - 2nd tab
        XCTAssertEqual(listTitle, "List")
        // -- end tab tests --
        
        
        // - when - badge
        let badgeValue = mapVC!.tabBarItem.badgeValue!
        let carsCount = "\(cars.count)"
        // - then - badge
        XCTAssertEqual(badgeValue, carsCount)
        
        // - when - tab count
        let tabs = rootTabBarController.tabBar.items
        let tabsCount = tabs?.count
        let allTabs = 2
        // - then - tab count
        XCTAssertEqual(tabsCount, allTabs)
    }
}

// MARK: ListCars tests
extension Cars_MapTests {
    func testListCarsTableView() {
        
        // - given -
        let cars = makeCars()
        let listCarsVM = ListCarsVM(cars: cars)
        let listCarsVC = ListCarsVC.`init`(listCarsVM: listCarsVM)
        let _ = listCarsVC.view
        
        // - when - cells
        let actualFirstCell = listCarsVC.tableView(listCarsVC.tableViewCars, cellForRowAt: IndexPath(row: 0, section: 0))
        let cellText = actualFirstCell.textLabel?.text
        let firstCar = cars[0]
        
        // - then - cells
        XCTAssertNotNil(actualFirstCell)
        // text
        XCTAssertEqual(cellText, firstCar.modelName)
        // accessor type
        XCTAssertEqual(actualFirstCell.accessoryType, .disclosureIndicator)
        
        
        // - when - table view rows
        let carsCount = cars.count
        let tblViewRows = listCarsVC.tableViewCars.numberOfRows(inSection: 0)
        // - then - table view rows
        XCTAssertEqual(tblViewRows, carsCount)
    }
    
    func testListCarsVM() {
        
        // - given -
        let cars = makeCars()
        let listCarsVM = ListCarsVM(cars: cars)
        let listCarsVC = ListCarsVC.`init`(listCarsVM: listCarsVM)
        let _ = listCarsVC.view
        
        // - when - cells
        let actual_VC_Cell = listCarsVC.tableView(listCarsVC.tableViewCars, cellForRowAt: IndexPath(row: 0, section: 0))
        let actual_VM_Cell = listCarsVM.itemFor(row: 0)
        // - then - cells
        XCTAssertNotNil(actual_VC_Cell)
        XCTAssertNotNil(actual_VM_Cell)
        
        
        // - when - cell text
        let vcCellText = actual_VC_Cell.textLabel?.text
        let vmCellText = actual_VM_Cell.textLabel?.text
        // - then - cell text
        XCTAssertEqual(vcCellText, vmCellText)
        
        // - when - accessory type
        let vcCellAT = actual_VC_Cell.accessoryType
        let vmCellAT = actual_VM_Cell.accessoryType
        // - then - accessory type
        XCTAssertEqual(vcCellAT, vmCellAT)
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


// TODO: good to write tests for
// - checking fall-back images of cars
// - mapkit testing
// - modal page testing
