//
//  CatsViewModel.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit
import MapKit

class MapCarsVM {
    
    // MARK: Delegates
    var mapCarsCoordinatorDelegate: MapCarsViewModelCoordinatorDelegate?
    var viewDelegate: MapCarsViewModelViewDelegate?
    
    // MARK: Properties
    private let cars: [Car]!
    
    // MARK: Init
    init(cars: [Car]) { self.cars = cars }
    
    func start() {
        // convert cars to annotations
        let carAnnotations = convertCarsToannotations(from: cars)
        // call VC to refresh
        viewDelegate?.refreshScreen(with: carAnnotations)
    }
    
    private func convertCarsToannotations(from cars: [Car]) -> [CarAnnotation] {
        var carAnnotations: [CarAnnotation] = []
        for car in cars {
            let carViewData = CarViewData(car: car)
            let carAnnotation = CarAnnotation(carData: car,
                                              coordinate: carViewData.coordinate)
            carAnnotations.append(carAnnotation)
        }
        return carAnnotations
    }
}

// MARK: - ViewModelType
extension MapCarsVM: MapCarsVMType {
    
    // DataSource
    func viewDataFor(annotation: MKAnnotation) -> Car {
        let carAnnotation = annotation as! CarAnnotation
        // force unwrapp because we're sure it's type of CarAnnotation
        return carAnnotation.carData
    }
    // TODO:
    // make an abstraction for all annotations
    // do switch on annotations and pass back data to VC
    // on VC assign datas to views
    
    // Events
    func didSelectAnnotation(view: MKAnnotationView, from: MKMapView) {
        // go to show modal page
        // view = CarAnnotation
        didSelect(view, from: from)
    }
}

// MARK: - ViewModelCoordinator
extension MapCarsVM: MapCarsViewModelCoordinatorDelegate {
    func didSelect(_ annotationView: MKAnnotationView, from mapView: MKMapView) {
        mapCarsCoordinatorDelegate?.didSelect(annotationView, from: mapView)
    }
}
