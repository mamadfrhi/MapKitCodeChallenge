//
//  ViewModelAbstractions.swift
//  Cat Facts
//
//  Created by iMamad on 4/9/22.
//

import UIKit
import MapKit

// MARK: - ViewModelType
protocol MapCarsVMType {
    
    var viewDelegate: MapCarsViewModelViewDelegate? { get set }

//    // Data Source
//    func numberOfItems() -> Int

    func viewFor(annotation: MKAnnotation) -> MKAnnotationView?
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
    func refreshScreen(with annotaions: [CarAnnotation]) // TODO: make it more abstract
    func selected(car: Car)
}
