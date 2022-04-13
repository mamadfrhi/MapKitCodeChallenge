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
    var carData: Car?
    
    
    // MARK: Init
    // custom
    init(carData: Car?, annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.carData = carData
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        self.addSubview(self.imageView)
    }
    // defatults
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
