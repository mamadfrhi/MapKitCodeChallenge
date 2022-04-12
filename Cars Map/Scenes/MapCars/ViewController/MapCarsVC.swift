//
//  MapCarsVC.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit
import MapKit

class MapCarsVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: Properties
    var viewModel: MapCarsViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        viewModel.start()
    }
}

// MARK: - ViewModel Delegate
extension MapCarsVC: MapCarsViewModelViewDelegate {
    func refreshScreen(with annotations: [CarAnnotation]) {
        print("refreshScreen functino in MapCarsVC received \(annotations.count) cars")
        self.mapView.showAnnotations(annotations, animated: true)
    }
    
    func selected(car: Car) {
        print("selected function in MapCarsVC received \(car) cars")
    }
}

//MARK: Map Delegate
extension MapCarsVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annView = viewModel.viewFor(annotation: annotation)
        return annView
    }
}
