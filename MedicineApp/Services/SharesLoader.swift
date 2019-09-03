//
//  SharesLoader.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 29/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class SharesLoader {
    
    func getShareWithId(idClinic: Int, completion: @escaping (_ result: [Share])->()){
        
        print("request : https://mp3cloud.ru/dentallapp/shares.php?idClinic=\(idClinic)")
        Alamofire.request("https://mp3cloud.ru/dentallapp/shares.php?idClinic=\(idClinic)",
            method: .get).responseJSON {
                response in
                if let comment = Mapper<Share>().mapArray(JSONObject:response.result.value){
                    completion(comment)
                    
                }
        }
    }
    
    func getShares(completion: @escaping (_ result: [Share])->()){
        
        //print("request : https://mp3cloud.ru/dentallapp/shares.php")
        Alamofire.request("https://mp3cloud.ru/dentallapp/shares.php",
            method: .get).responseJSON {
                response in
                if let comment = Mapper<Share>().mapArray(JSONObject:response.result.value){
                    completion(comment)
                    
                }
        }
    }
    
}

