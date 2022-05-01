//
//  AppServices.swift
//  Cars Map
//
//  Created by iMamad on 4/15/22.
//

import Foundation


protocol Serviceable: class {
    func fetchCars(completionHandler: @escaping (Any?, Error?) -> ())
}

class AppServices: Serviceable {
    
    private var apiClient: Network?
    
    // MARK: Init
    init(apiClient: Network) { self.apiClient = apiClient }
}

// MARK:- API Call
extension AppServices {
    func fetchCars(completionHandler: @escaping (Any?, Error?) -> ()){
        apiClient?.fetch { (result) in
            switch result {
            case .success(let cat):
                completionHandler(cat, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}

// -- Service Layer --
// AppServices is a general class to use all over the app
// however, the architecture is potential
// to use same service design pattern per each scene

// I know it's much for this pet-project, but I added services layer and the statemet above
// to show how do I care about scalability & testability & loose coupling etc. of the app.
