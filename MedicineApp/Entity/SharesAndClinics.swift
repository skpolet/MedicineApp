//
//  SharesAndClinics.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 05/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import ObjectMapper

class SharesAndClinics: Mappable {
    var share: [Shares]?
    var clinic: [Clinics]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        share <- map["shares"]
        clinic <- map["clinics"]
    }
}
