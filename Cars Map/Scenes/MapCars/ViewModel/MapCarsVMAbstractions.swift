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

    // Data Source
    func viewFor(annotation: MKAnnotation, on mapView: MKMapView) -> MKAnnotationView?

    // Events
    func didSelectAnnotation(view: MKAnnotationView, from: MKMapView)
}

// MARK: - ViewModelCoordinator(delegate)
protocol MapCarsViewModelCoordinatorDelegate {
    func didSelect(_ annotationView: MKAnnotationView, from mapView: MKMapView)
}

// MARK: - ViewModelViewDelegate
protocol MapCarsViewModelViewDelegate {
    func refreshScreen(with annotaions: [MKAnnotation])
}
