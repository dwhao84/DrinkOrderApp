//
//  KebukeAnnotation.swift
//  DrinkOrderApp
//
//  Created by Dawei Hao on 2024/4/27.
//

import UIKit
import MapKit

class KebukeAnnotation: MKPointAnnotation {
    
    static let identifier: String = "KebukeAnnotation"
    
    var image: UIImage?
    
    init(coordinate: CLLocationCoordinate2D, title: String, image: UIImage)  {
        super.init()
        self.coordinate = coordinate
        self.image = image
        self.title = title
    }
}
