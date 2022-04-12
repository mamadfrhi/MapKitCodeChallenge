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
    
    var viewDelegate: ListCarsViewModelViewDelegate? { get set }
    
    // Data Source
    func numberOfItems() -> Int
    
    func itemFor(row: Int) -> UITableViewCell
    
    // Events
    func didSelectRow(_ row: Int, from controller: UIViewController)
    
    func refreshView()
}

// MARK: - ViewModelCoordinator(delegate)
protocol ListCarsViewModelCoordinatorDelegate: class {
    func didSelect(car: Car, from controller: UIViewController)
}

// MARK: - ViewModelViewDelegate
protocol ListCarsViewModelViewDelegate: class {
    func refreshScreen(with annotaions: [Car])
    func selected(car: Car)
}
