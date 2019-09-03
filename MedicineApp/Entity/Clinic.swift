//
//  Clinics.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 05/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class Clinic: Mappable {
    var id: Int?
    var title: String?
    var highlight: Int?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var rating: Double?
    var distance: Int?
    
    required init?(map: Map){
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["idClinic"]
        title <- map["title"]
        highlight <- map["highlight"]
        address <- map["address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        rating <- map["rating"]
        distance <- map["distance"]
    }
}
