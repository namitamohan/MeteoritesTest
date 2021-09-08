//
//  MapViewExtension.swift
//  MeteoriteTest
//
//  Created by Namita on 9/5/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
