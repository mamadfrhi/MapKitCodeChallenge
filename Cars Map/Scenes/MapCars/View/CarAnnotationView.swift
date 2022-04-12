//
//  CarAnnotation.swift
//  Cars Map
//
//  Created by iMamad on 4/12/22.
//

import MapKit

class CarAnnotationView: MKAnnotationView {
    var imageView: UIImageView!
    // TODO: It's not a good place to encode data!
    var carData: Car?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        self.addSubview(self.imageView)
        
        self.imageView.layer.cornerRadius = 5.0
        self.imageView.layer.masksToBounds = true
    }
    
    override var image: UIImage? {
        get { return self.imageView.image }
        
        set { self.imageView.image = newValue }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
