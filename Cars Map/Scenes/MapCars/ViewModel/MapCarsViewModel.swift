//
//  CatsViewModel.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit
import MapKit

class MapCarsViewModel {
    
    // MARK: Delegates
    var mapCarsCoordinatorDelegate: MapCarsViewModelCoordinatorDelegate?
    var viewDelegate: MapCarsViewModelViewDelegate?
    
    // MARK: Properties
    var cars: [Car] = []
    // check if it must be weak or not
    
    // MARK: Init
    init() {}
    
    func start() {
        // convert cars to annotations
        var carAnnotations: [CarAnnotation] = []
        for car in cars {
            let carViewData = CarViewData(car: car)
            let carAnnotation = CarAnnotation(coordinate: carViewData.coordinate,
                                              title: carViewData.name,
                                              imageUrl: carViewData.carImageUrl)
            carAnnotations.append(carAnnotation)
        }
        // call VC
        viewDelegate?.refreshScreen(with: carAnnotations)
    }
}

// Implement interface below for MapVM


// MARK: - ViewModelType
extension MapCarsViewModel: MapCarsViewModelType {
    
    func viewFor(annotation: MKAnnotation) -> MKAnnotationView? {
        //Handle user location annotation..
        if annotation.isKind(of: MKUserLocation.self) {
            return nil  //Default is to let the system handle it.
        }
        
        //Handle non-ImageAnnotations..
        if !(annotation.isKind(of: CarAnnotation.self)) {
            return nil  //Default is to let the system handle it.
        }
        
        //Handle CarAnnotation..
        let carAnnotation = annotation as! CarAnnotation // force unwrap because we checked it above
        let annotationView = CarAnnotationView(annotation: annotation, reuseIdentifier: "imageAnnotation")
        annotationView.imageView.downloaded(from: carAnnotation.imageUrl) // Assign related image to it
        return annotationView
    }
}

// MARK: - ViewModelCoordinator
extension MapCarsViewModel: MapCarsViewModelCoordinatorDelegate {
    func didSelect(car: Car, from controller: UIViewController) {
        mapCarsCoordinatorDelegate?.didSelect(car: car,
                                              from: controller)
        // It'll open CarsDetail VC
    }
}
