//
//  CarInfoVC.swift
//  Cars Map
//
//  Created by iMamad on 4/12/22.
//

import UIKit

class CarInfoVC: UIViewController {
    
    //MARK: Properties
    let car: Car? = nil // write a test to make sure always it's not nil after showing
    
    //MARK: Outlets
    @IBOutlet weak var gasImageView: UIImageView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var fuelPercentage: UILabel!
    @IBOutlet weak var infoText: UITextView!
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: setup
    private func setup() {
        guard let car = car else { return }
        // Fuel module
        self.gasImageView.image = gasImageView.image?.fill(with: .red,
                                                           percentage: CGFloat(car.fuelLevel))
        fuelPercentage.text = "\(car.fuelLevel * 100)%"
        // TODO: it's a good idea to make a module from
        // percentage label and the gas icon and re-use it everywhere
        
        carImageView.downloaded(from: car.carImageUrl)
        // TODO: Car image is downloading 1 time at CarMapsVM
        // so to prevent 2 same network calls it's better to assign
        // downloaded image to car model 1 time and pass it through app
        
        infoText.text = makeText(car: car)
    }
    
    private func makeText(car: Car) -> String {
        let words = [
            car.modelName,
            car.name,
            car.make,
            car.color
        ]
        var str = ""
        for word in words {
            str += "\n\(word)"
        }
        return str
    }
}

extension UIImage {
    func fill(with color: UIColor, percentage: CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: rect)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setBlendMode(CGBlendMode.sourceIn)
        
        context.setFillColor(color.cgColor)
        
        let start = (rect.height)-( size.height*percentage)
        let rectToFill = CGRect(x: 0, y: start, width: size.width, height: size.height*percentage)
        
        context.fill(rectToFill)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
