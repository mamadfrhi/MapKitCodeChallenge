//
//  MapCarsVC.swift
//  Cars Map
//
//  Created by iMamad on 4/11/22.
//

import UIKit

class MapCarsVC: UIViewController {
    
    // MARK: Outlets
    
    
    // MARK: Properties
    var viewModel: MapCarsViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
    }
    
    // MARK: Setup
    
    // MARK: Actions
    @IBAction func retry(_ sender: Any) {
        
    }
}

// MARK: - ViewModel Delegate
extension MapCarsVC: MapCarsViewModelViewDelegate {
    func refreshScreen(with cars: [Car]) {
        print("refreshScreen functino in MapCarsVC received \(cars.count) cars")
    }
    
    func selected(car: Car) {
        print("selected function in MapCarsVC received \(car) cars")
    }
    
    
}
