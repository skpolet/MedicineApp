//
//  DrawRoute.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 05/09/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Alamofire

class DrawRoute{
    
    func getPolylineRoute(clinic: Clinic, myLong: Double, myLat: Double, completion: @escaping (_ result: GMSPolyline)->()){
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(String(describing: clinic.latitude)),\(String(describing: clinic.longitude))&destination=\(myLat),\(myLong)&mode=driving&key=AIzaSyDZARmmMu8nnyW5SP3XeeASajhd08QK4q4")!
        
        print("urlrequest: \(url)")
        Alamofire.request(
            url,
            method: .get).responseJSON {
                response in
//                if let routes = response["routes"].arrayValue{
//                    //completion(locationList)
//                }
                print("response : \(response)")
        }
    }
}
