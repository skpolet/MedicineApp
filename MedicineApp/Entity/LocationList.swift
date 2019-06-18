//
//  LocationList.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import ObjectMapper

class LocationList: Mappable {
    var location : [Location]?
    
    required init?(map: Map){        
    }
    
    func mapping(map: Map) {
        location <- map["city"]
    }
}
