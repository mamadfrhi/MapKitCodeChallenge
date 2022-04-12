//
//  CarAnnotation.swift
//  Cars Map
//
//  Created by iMamad on 4/12/22.
//

import MapKit

class CarAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var imageUrl: String

    init(coordinate: CLLocationCoordinate2D, title: String, imageUrl: String) {
        self.coordinate = coordinate
        self.title = title
        self.imageUrl = imageUrl
    }
}
