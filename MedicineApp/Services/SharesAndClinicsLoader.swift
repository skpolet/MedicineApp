//
//  SharesLoader.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 05/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class SharesAndClinicsLoader: NSObject {
    
    func getSharesAndClinics(completion: @escaping (_ result: SharesAndClinics)->()){
        
        Alamofire.request(
            "https://mp3cloud.ru/dentallapp/main.php?screen=main",
            method: .get).responseJSON {
                response in
                if let sharesAndClinics = Mapper<SharesAndClinics>().map(JSONObject:response.result.value){
                    completion(sharesAndClinics)
                }
        }
    }
}
