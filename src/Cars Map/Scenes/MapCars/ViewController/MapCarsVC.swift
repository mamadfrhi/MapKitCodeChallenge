//
//  MapCarsVC.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit
import MapKit


class MapCarsVC: UIViewController {
    
    // MARK: Factory
    class func `init`(mapCarsVM: MapCarsVM) -> MapCarsVC {
        let storyboard = UIStoryboard(name: "MapCars", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapCarsVC") as! MapCarsVC
        // take care of force unwrapping above
        vc.viewModel = mapCarsVM
        return vc
    }
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Properties
    var viewModel: MapCarsVM! {
        didSet { viewModel.viewDelegate = self }
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
    func refreshScreen(with annotations: [MKAnnotation]) {
        mapView.showAnnotations(annotations, animated: true)
    }
}

//MARK: Map Delegate
extension MapCarsVC: MKMapViewDelegate {
    // annotation view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annView = viewModel.viewFor(annotation: annotation, on: mapView)
        return annView
    }
    
    // didSelect Event
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        viewModel.didSelectAnnotation(view: view, from: mapView)
    }
}