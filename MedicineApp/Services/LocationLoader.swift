//
//  LocationLoader.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class LocationLoader: NSObject {
    
    func getLocations(completion: @escaping (_ result: LocationList)->()){

        Alamofire.request(
            "https://\(Adress.domain.value())/\(Adress.versionAPI.value())/main.php?screen=city",
            method: .get).responseJSON {
                response in
                if let locationList = Mapper<LocationList>().map(JSONObject:response.result.value){
                completion(locationList)
                }
        }
    }
}
