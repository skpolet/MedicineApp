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
        
        //print("request : https://\(Adress.domain.value())/\(Adress.versionAPI.value())/shares.php?idClinic=\(idClinic)")
        Alamofire.request("https://\(Adress.domain.value())/\(Adress.versionAPI.value())/shares.php?idClinic=\(idClinic)",
            method: .get).responseJSON {
                response in
                if let comment = Mapper<Share>().mapArray(JSONObject:response.result.value){
                    completion(comment)
                    
                }
        }
    }
    
    func getShares(completion: @escaping (_ result: [Share], _ connectionStatus: ReachabilityStatus)->()){
        
        //print("request : https://\(Adress.domain.value())/\(Adress.versionAPI.value())/shares.php")
        Alamofire.request("https://\(Adress.domain.value())/\(Adress.versionAPI.value())/shares.php",
            method: .get).responseJSON {
                response in
                let status = Reach().connectionStatus()
                if let shares = Mapper<Share>().mapArray(JSONObject:response.result.value){
                    completion(shares,status)
                    
                }else{
                    completion([],status)
                }
                
        }
    }
    
}

