//
//  MapVC.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 28/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, MKMapViewDelegate {
    
    var plan: String!
    
    var mapView                 = MKMapView()
    private let locationManager = CLLocationManager()
    private var currentPlace: CLPlacemark?
    
    
    init(plan: String) {
        super.init(nibName: nil, bundle: nil)
        self.plan   = plan
        title       = plan
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureMapView()
        attemptLocationAccess()
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate( [
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: true)
            findPlaces(region: region)
        }
    }
    
    func attemptLocationAccess() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            break
        case .denied:
            //Show Alert
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // Show an alert
            break
        case .authorizedAlways:
            break
        @unknown default:
            //
            break
        }
    }
    
    func findPlaces(region: MKCoordinateRegion) {
        
        let searchRequest                   = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery  = plan!
        searchRequest.region                = region
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            guard let response = response else {
                print("Error")
                return
            }
            for item in response.mapItems {
                let anotation = MKPointAnnotation()
                anotation.title = item.name!
                anotation.coordinate = CLLocationCoordinate2DMake(item.placemark.coordinate.latitude, item.placemark.coordinate.longitude)
                self.mapView.addAnnotation(anotation)
                
            }
        }
    }

}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}