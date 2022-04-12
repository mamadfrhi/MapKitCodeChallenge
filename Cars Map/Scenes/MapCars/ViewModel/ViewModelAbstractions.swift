//
//  ViewModelAbstractions.swift
//  Cat Facts
//
//  Created by iMamad on 4/9/22.
//

import UIKit
import MapKit

// MARK: - ViewModelType
protocol CatsViewModelType {
    
    var viewDelegate: MapCarsViewModelViewDelegate? { get set }

//    // Data Source
//    func numberOfItems() -> Int
//
//    func itemFor(row: Int) -> UITableViewCell
//
//    // Events
//    func add()
//
//    func delete()
//
//    func didSelectRow(_ row: Int, from controller: UIViewController)
//
//    func refreshView()
}

// MARK: - ViewModelCoordinator(delegate)
protocol MapCarsViewModelCoordinatorDelegate: class {
    func didSelect(car: Car, from controller: UIViewController)
}

// MARK: - ViewModelViewDelegate
protocol MapCarsViewModelViewDelegate: class {
    func refreshScreen(with annotaions: [MKPointAnnotation])
    func selected(car: Car)
}
