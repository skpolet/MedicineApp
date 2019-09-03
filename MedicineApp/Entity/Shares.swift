//
//  Shares.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 05/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class Share: Mappable {
    var id: Int?
    var idClinic : Int?
    var nameClinic : String?
    var title: String?
    var description: String?
    var highlight: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["idShare"]
        idClinic  <- map["idClinic"]
        nameClinic <- map["nameClinic"]
        title <- map["title"]
        description <- map["description"]
        highlight <- map["highlight"]
    }
}
