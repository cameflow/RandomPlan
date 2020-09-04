//
//  Place.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 29/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit
import MapKit

class Place: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, subtitle: String) {
        self.title      = title
        self.coordinate = coordinate
        self.subtitle       = subtitle
    }

}
