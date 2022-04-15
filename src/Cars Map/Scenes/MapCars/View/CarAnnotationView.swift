//
//  CarAnnotation.swift
//  Cars Map
//
//  Created by iMamad on 4/12/22.
//

import MapKit

class CarAnnotationView: MKAnnotationView {
    
    // MARK: Properties
    // default
    override var image: UIImage? {
        get { return self.imageView.image }
        
        set { self.imageView.image = newValue }
    }
    // customs
    var imageView: UIImageView!
    let carData: Car!
    
    
    // MARK: Init
    init(carData: Car?, annotation: MKAnnotation?, reuseIdentifier: String?, desiredWidth: Int) {
        self.carData = carData
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.frame = CGRect(x: 0, y: 0, width: desiredWidth, height: desiredWidth)
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: desiredWidth, height: desiredWidth))
        self.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
