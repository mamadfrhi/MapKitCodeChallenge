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
        
        // MARK: Start the test
        // reach 1st tab
        let mapNav = rootTabBarController.viewControllers?[0] as? UINavigationController
        let mapVC = mapNav?.viewControllers.first as? MapCarsVC
        let mapTitle = mapVC?.title
        XCTAssertEqual(mapTitle, "Map")
        
        // reach 2nd tab
        let listNav = rootTabBarController.viewControllers?[1] as? UINavigationController
        let listVC = listNav?.viewControllers.first as? ListCarsVC
        let listTitle = listVC?.title
        XCTAssertEqual(listTitle, "List")
        
        
        // test badge
        // violates SRP
        let badgeValue = mapVC!.tabBarItem.badgeValue!
        let carsCount = "\(cars.count)"
        XCTAssertEqual(badgeValue, carsCount)
        
        // test order of tabs
        let tabs = rootTabBarController.tabBar.items
        let tabsCount = tabs?.count
        let allTabs = 2
        XCTAssertEqual(tabsCount, allTabs)
    }
}

// MARK: TableView tests
extension Cars_MapTests {
    func testTableView() {
        
        // preapre
        let cars = makeCars()
        let listCarsVM = ListCarsVM(cars: cars)
        let listCarsVC = ListCarsVC.`init`(listCarsVM: listCarsVM)
        let _ = listCarsVC.view
        let actualFirstCell = listCarsVC.tableView(listCarsVC.tableViewCars, cellForRowAt: IndexPath(item: 0, section: 0))
        // MARK: Start the test
        let cellText = actualFirstCell.textLabel?.text
        let firstCar = cars[0]
        
        // test cells
        XCTAssertNotNil(actualFirstCell)
        // text
        XCTAssertEqual(cellText, firstCar.modelName)
        // accessor type
        XCTAssertEqual(actualFirstCell.accessoryType, .disclosureIndicator)
        
        // table view
        let carsCountVM = listCarsVM.numberOfItems()
        let tblViewRows = listCarsVC.tableViewCars.numberOfRows(inSection: 0)
        XCTAssertEqual(tblViewRows, carsCountVM)
    }
    
    func testListCarsVM() {
        
        // - given -
        let cars = makeCars()
        let listCarsVM = ListCarsVM(cars: cars)
        let listCarsVC = ListCarsVC.`init`(listCarsVM: listCarsVM)
        let _ = listCarsVC.view
        
        // - when -
        let actualVCCell = listCarsVC.tableView(listCarsVC.tableViewCars, cellForRowAt: IndexPath(row: 0, section: 0))
        let actualVMCell = listCarsVM.itemFor(row: 0)
        
        // - then -
        XCTAssertNotNil(actualVCCell)
        XCTAssertNotNil(actualVMCell)
        
        // text
        let vcCellText = actualVCCell.textLabel?.text
        let vmCellText = actualVMCell.textLabel?.text
        XCTAssertEqual(vcCellText, vmCellText)
        
        // accessory type
        let vcCellAT = actualVCCell.accessoryType
        let vmCellAT = actualVMCell.accessoryType
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
