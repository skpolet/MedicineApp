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

class Clinics: Mappable {
    var id: String?
    var title: String?
    var highlight: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        highlight <- map["highlight"]
    }
}
