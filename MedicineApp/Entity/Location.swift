//
//  Location.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import Alamofire
//import AlamofireObjectMapper
import ObjectMapper

class Location: Mappable {
    var id: String?
    var regionId: String?
    var title: String?
    var highlight: String?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        let mapItems = map["city"]
        id <- mapItems["id"]
        regionId <- mapItems["regionId"]
        title <- mapItems["title"]
        highlight <- mapItems["highlight"]
        print("mapItems: \(mapItems), items :\(String(describing: title))")
    }
}
