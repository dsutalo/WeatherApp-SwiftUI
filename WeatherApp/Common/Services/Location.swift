//
//  Location.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 11.10.2021..
//

import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    var onLocationChanged: ((Double,Double) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        if let location = lastKnownLocation {
            onLocationChanged?(location.latitude, location.longitude)
            manager.stopUpdatingLocation()
        }
    }
}

