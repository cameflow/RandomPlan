//
//  MapVC.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 28/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, CLLocationManagerDelegate {
    
    var plan: String!
    
    var mapView                 = MKMapView()
    private let locationManager = CLLocationManager()
    
    
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
        view.backgroundColor = .systemPink
        configureMapView()
        attemptLocationAccess()
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate( [
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    func attemptLocationAccess() {
        guard CLLocationManager.locationServicesEnabled() else {
          return
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .notDetermined {
          locationManager.requestWhenInUseAuthorization()
        } else {
          locationManager.requestLocation()
        }
    }
    

    
    


}
