//
//  ViewModelAbstractions.swift
//  Cat Facts
//
//  Created by iMamad on 4/9/22.
//

import UIKit
import MapKit

// MARK: - ViewModelType
protocol ListCarsVMType {
    // Data Source
    func numberOfItems() -> Int
    
    func itemFor(row: Int) -> Any
    
    // Events
    func didSelectRow(_ row: Int, from controller: UIViewController)
}

// MARK: - ViewModelCoordinator(delegate)
protocol ListCarsViewModelCoordinatorDelegate: class {
    func didSelect(carViewData: CarViewData, from controller: UIViewController)
}


// MARK: - ViewModelViewDelegate
//protocol ListCarsViewModelViewDelegate: class {
//    func refreshScreen(with annotaions: [Car])
//}
// Just to show the code is sOlid ( open to extension )
