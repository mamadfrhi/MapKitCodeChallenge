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
    private let carViewDatas: [CarViewData]
    
    // MARK: Init
    init(carViewDatas: [CarViewData]) { self.carViewDatas = carViewDatas }
    
    func start() {
        // convert cars to annotations
        let carAnnotations = convertCarViewDatasToannotations(from: carViewDatas)
        // call VC to refresh
        viewDelegate?.refreshScreen(with: carAnnotations)
    }
    
    private func convertCarViewDatasToannotations(from carViewDatas: [CarViewData]) -> [CarAnnotation] {
        var carAnnotations: [CarAnnotation] = []
        for carViewData in carViewDatas {
            let carAnnotation = CarAnnotation(carViewData: carViewData,
                                              coordinate: carViewData.coordinate)
            carAnnotations.append(carAnnotation)
        }
        return carAnnotations
    }
}

// MARK: - ViewModelType
extension MapCarsVM: MapCarsVMType {
    
    // DataSource
    func viewDataFor(annotation: MKAnnotation) -> CarViewData {
        let carAnnotation = annotation as! CarAnnotation
        // force unwrapp because we're sure it's type of CarAnnotation
        return carAnnotation.carViewData
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
