//
//  MeteoriteLocationViewController.swift
//  MeteoriteTest
//
//  Created by Namita on 9/3/21.
//  Copyright © 2021 Namita. All rights reserved.
//

import UIKit
import MapKit

class MeteoriteLocationViewController: UIViewController {
    
    var meteorite: Meteorite?
    @IBOutlet weak var meteoriteMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        showOnMap()
    }
    
    func setupViews() {
        title = meteorite?.name
        meteoriteMapView.delegate = self
        let initialLocation = CLLocation(latitude: meteorite?.latDouble ?? 0, longitude: meteorite?.longDouble ?? 0)
        meteoriteMapView.centerToLocation(initialLocation)
        
        let region = MKCoordinateRegion(
          center: initialLocation.coordinate,
          latitudinalMeters: 50000,
          longitudinalMeters: 60000)
        meteoriteMapView.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        meteoriteMapView.setCameraZoomRange(zoomRange, animated: true)
    }
    
    func showOnMap() {
        
        var title = meteorite?.name
        if let name = meteorite?.name, let recClass = meteorite?.recclass {
            title = "\(name) (\(recClass))"
        }
        
        let location = MeteoriteLoc(
            title: title,
            fall: meteorite?.fall,
            mass: meteorite?.mass,
            year: meteorite?.yearString,
            coordinate: CLLocationCoordinate2D(latitude: meteorite?.latDouble ?? 0, longitude: meteorite?.longDouble ?? 0))
        meteoriteMapView.addAnnotation(location)
    }
}

extension MeteoriteLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? MeteoriteLoc else {
          return nil
        }
        
        let identifier = "meteoriteLoc"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.loadCustomLines(customLines: [(annotation.subtitle ?? ""), annotation.secondSubtitle])
        }
        return view
    }
    
}
