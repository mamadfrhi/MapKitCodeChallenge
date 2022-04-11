//
//  Car.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//


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
