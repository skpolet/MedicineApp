//
//  TestMapController.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 17/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TestMapController: UIViewController,CLLocationManagerDelegate {
    @IBOutlet var map: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: map)
            //print(position.x)
            let location = map.convert(position, toCoordinateFrom: map)
            retreiveCityName(lattitude: location.latitude, longitude: location.longitude) { (nameCity) in
                        print("nameCity\(String(describing: nameCity))")
                    }
        }
    }
    
    func retreiveCityName(lattitude: Double, longitude: Double, completionHandler: @escaping (String?) -> Void)
    {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: lattitude, longitude: longitude), completionHandler:
            {
                placeMarks, error in
                
                completionHandler(placeMarks?.first?.locality)
                completionHandler(placeMarks?.first?.administrativeArea)
        })
    }

}
