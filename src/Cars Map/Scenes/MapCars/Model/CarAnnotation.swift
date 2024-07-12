//
//  CarAnnotation.swift
//  Cars Map
//
//  Created by iMamad on 4/12/22.
//

import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    // default
    var title: String?
    var subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    // customs
    let carViewData : CarViewData!
    
    init(carViewData: CarViewData, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = carViewData.modelName
        self.subtitle = carViewData.name
        self.carViewData = carViewData
    }
}
