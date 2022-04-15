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
    var carData : Car
    
    var carImageUrl: String {
        return carData.carImageUrl
    }
    
    init(carData: Car, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = carData.modelName
        self.subtitle = carData.name
        self.carData = carData
    }
}
