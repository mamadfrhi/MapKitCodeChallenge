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



class CarViewData: CarViewDataType {
    // MARK: custom properties
    var coordinate: CLLocationCoordinate2D {
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude),
                                                longitude: CLLocationDegrees(longitude))
        return coordinate
    }
    
    var uiImage = UIImage(named: "car")!
    
    // MARK: properties
    var id: String { return car.id }
    
    var modelName: String{ return car.modelName }
    
    var name: String{ return car.name }
    
    var make: String{ return car.make }
    
    var color: String{ return car.color }
    
    var fuelLevel: Float{ return car.fuelLevel }
    
    var latitude: Float{ return car.latitude }
    
    var longitude: Float{ return car.longitude }
    
    var carImageUrl: String { return car.carImageUrl }
    
    // MARK: Init
    private let car: Car
    
    init(car: Car) {
        self.car = car
        if let url = URL(string: carImageUrl) { downloadImage(from: url) }
    }
    
    
    //MARK: Image Downloader
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.uiImage = UIImage(data: data) ?? self.uiImage
            }
        }
    }
}
