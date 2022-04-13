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
    private var cars: [Car] = []
    
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
        // too keep code base clean you can remove dequeueReusableAnnotationView too.
        let carAnnotation = annotation as! CarAnnotation // force unwrap because we checked it above
        let carData = carAnnotation.carData
        // start to make annotationVIEW
        var carAnnotationView: CarAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "carAnnotationView") as? CarAnnotationView
        
        if carAnnotationView == nil {
            carAnnotationView = CarAnnotationView(carData: carData,
                                                  annotation: annotation,
                                                  reuseIdentifier: "carAnnotationView")
            carAnnotationView!.imageView.downloaded(from: carData.carImageUrl)
        }
        
        return carAnnotationView
    }
    
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
