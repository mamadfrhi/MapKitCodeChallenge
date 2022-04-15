//
//  Car.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import MapKit
import CoreLocation

protocol CarViewDataType {
    var id: String { get }
    var modelName: String { get }
    var name: String { get }
    var make: String { get }
    var color: String { get }
    var fuelLevel: Float { get }
    var latitude: Float { get }
    var longitude: Float { get }
    var carImageUrl: String { get }
}

struct Car: Decodable {
    let id: String
    let modelName: String
    let name: String
    let make: String
    let color: String
    let fuelLevel: Float
    let latitude: Float
    let longitude: Float
    let carImageUrl: String
}



struct CarViewData: CarViewDataType {
    // MARK: custom properties
    var coordinate: CLLocationCoordinate2D {
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude),
                                                longitude: CLLocationDegrees(longitude))
        return coordinate
    }
    
    var uiImage : UIImage?
    var carImageNativeUrl: URL? {
        return URL(string: car.carImageUrl)
    }
    
    // MARK: properties
    var id: String {
        return car.id
    }
    
    var modelName: String{
        return car.modelName
    }
    
    var name: String{
        return car.name
    }
    
    var make: String{
        return car.make
    }
    
    var color: String{
        return car.color
    }
    
    var fuelLevel: Float{
        return car.fuelLevel
    }
    
    var latitude: Float{
        return car.latitude
    }
    
    var longitude: Float{
        return car.longitude
    }
    
    var carImageUrl: String {
        return car.carImageUrl
    }
    
    // MARK: Init
    private let car: Car
    
    init(car: Car) { self.car = car }
}
