//
//  LocationCervices.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 17/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol LocationCoordinatble: AnyObject {
    func currentLocation(city: String?, region: String?)
    func currentLocation(longitude: Double?, latitude: Double?)
}

extension LocationCoordinatble {
    func currentLocation(city: String?, region: String?) {}
    func currentLocation(longitude: Double?, latitude: Double?) {}
}

class LocationServices : NSObject, CLLocationManagerDelegate {
    
    let location = SharedLocation.instance
    weak var delegate: LocationCoordinatble?
    let locationManager = CLLocationManager()
    
    static let instance = LocationServices()
    private override init(){
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        retreiveCityName(lattitude: locValue.latitude, longitude: locValue.longitude)
        //delegate?.currentLocation(longitude: locValue.longitude, latitude: locValue.latitude)
        location.longitude = locValue.longitude
        location.latitude = locValue.latitude
    }
    
    func retreiveCityName(lattitude: Double, longitude: Double)
    {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: lattitude, longitude: longitude), completionHandler:
            {
                placeMarks, error in
                //self.delegate?.currentLocation(city: placeMarks?.first?.locality, region: placeMarks?.first?.administrativeArea)
                if let city = placeMarks?.first?.locality, let region = placeMarks?.first?.administrativeArea{
                    self.location.city = city
                    self.location.region = region
                }

                self.locationManager.stopUpdatingLocation()
        })
    }

}
