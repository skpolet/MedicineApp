//
//  Comments.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 29/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class Comment: Mappable {
    var id: Int?
    var idClinic: Int?
    var title : String?
    var highlight : Int?
    var author : String?
    var date : String?
    var rating: Double?
    var text : String?
    
    required init?(map: Map){
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["idCommet"]
        idClinic <- map["idClinic"]
        highlight <- map["highlight"]
        title <- map["title"]
        author <- map["author"]
        date  <- map["date"]
        text  <- map["text"]
    }
}
