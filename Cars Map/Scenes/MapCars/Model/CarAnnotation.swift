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
    var coordinate: CLLocationCoordinate2D
    
    // customs
    private var car : Car
    
    var carImageUrl: String {
        return car.carImageUrl
    }
    
    init(car: Car, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = car.modelName
        self.subtitle = car.name
        self.car = car
    }
}
