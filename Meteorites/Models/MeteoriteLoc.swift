//
//  MeteoriteLoc.swift
//  MeteoriteTest
//
//  Created by Namita on 9/5/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import Foundation
import MapKit

class MeteoriteLoc: NSObject, MKAnnotation {
    
    let title: String?
    let fall: String?
    let mass: String?
    let year: String?
    let coordinate: CLLocationCoordinate2D

    init(
        title: String?,
        fall: String?,
        mass: String?,
        year: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.title = title
        self.fall = fall
        self.mass = mass
        self.year = year
        self.coordinate = coordinate
        
        super.init()
    }

    var subtitle: String? {
        
        var subtitle = year
        if let fall = fall, let year = year{
            subtitle = "\(fall) in \(year)"
        }
        return subtitle
    }
    
    var secondSubtitle: String {
        var string = mass
        if let mass = mass {
            string = "Mass: \(mass)"
        }
        return string ?? ""
    }
}
