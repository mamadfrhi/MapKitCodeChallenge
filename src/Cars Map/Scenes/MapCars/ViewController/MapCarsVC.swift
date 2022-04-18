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
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: Properties
    private var viewModel: MapCarsVM! {
        didSet { viewModel.viewDelegate = self }
    }
    private let annotationViewID = "carAnnotationView"
    private let annotationWidth = 70
    
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
        guard annotation is CarAnnotation else { return nil }
        
        let carData = viewModel.viewDataFor(annotation: annotation)
        let newCarAnnotationView = CarAnnotationView(carData: carData,
                                                     annotation: annotation,
                                                     reuseIdentifier: annotationViewID,
                                                     desiredWidth: annotationWidth)
        newCarAnnotationView.imageView.downloaded(from: carData.carImageUrl)
        return newCarAnnotationView
        // TODO: use dequeue reuse annotation view for smoothing moves on map
    }
    
    // didSelect Event
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        viewModel.didSelectAnnotation(view: view, from: mapView)
    }
}
