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
    var cars: [Car] = []
    // check if it must be weak or not
    
    // MARK: Init
    init() {}
    
    func start() {
        // convert cars to annotations
        var carAnnotations: [CarAnnotation] = []
        for car in cars {
            let carViewData = CarViewData(car: car)
            let carAnnotation = CarAnnotation(carData: car,
                                              coordinate: carViewData.coordinate)
            carAnnotations.append(carAnnotation)
        }
        // call VC
        viewDelegate?.refreshScreen(with: carAnnotations)
    }
}

// Implement interface below for MapVM


// MARK: - ViewModelType
extension MapCarsVM: MapCarsVMType {
    
    // DataSource
    func viewFor(annotation: MKAnnotation, on mapView: MKMapView) -> MKAnnotationView? {
        //Handle user location annotation..
        if annotation.isKind(of: MKUserLocation.self) {
            return nil  //Default is to let the system handle it.
        }
        
        //Handle non-CarAnnotations..
        if !(annotation.isKind(of: CarAnnotation.self)) {
            return nil  //Default is to let the system handle it.
        }
        
        //Handle CarAnnotation..
        // too keep code base clean you can remove reuse too.
        var view: CarAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "carAnnotationView") as? CarAnnotationView
        if view == nil {
            view = CarAnnotationView(annotation: annotation, reuseIdentifier: "carAnnotationView")
        }
        
        let carAnnotation = annotation as! CarAnnotation // force unwrap because we checked it above
        // make annotationVIEW
        let carData = carAnnotation.carData
        let carAnnotationView = CarAnnotationView(carData: carData, // write a test to check if it's injected or not!
                                                  annotation: annotation,
                                                  reuseIdentifier: "carAnnotationView")
        carAnnotationView.imageView.downloaded(from: carData.carImageUrl)
        return carAnnotationView
    }
    
    // Events
    func didSelectAnnotation(view: MKAnnotationView, from: MKMapView) {
        // go to show modal page
        didSelect(view, from: from)
    }
}

// MARK: - ViewModelCoordinator
extension MapCarsVM: MapCarsViewModelCoordinatorDelegate {
    func didSelect(_ annotationView: MKAnnotationView, from mapView: MKMapView) {
        guard let carAnnotationView = annotationView as? CarAnnotationView else { return }
        mapCarsCoordinatorDelegate?.didSelect(carAnnotationView, from: mapView)
    }
}
