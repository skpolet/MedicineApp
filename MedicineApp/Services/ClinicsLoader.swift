//
//  ClinicsLoader.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 16/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ClinicsLoader: NSObject {
    
//    func getClinicsToMap(completion: @escaping (_ result: [Clinics])->()){
//
//        Alamofire.request("https://mp3cloud.ru/dentallapp/clinics.php?latitude=55.918022&longitude=37.842363",
//            method: .get).responseJSON {
//                response in
//                if let clinics = Mapper<Clinics>().mapArray(JSONObject:response.result.value){
//                    completion(clinics)
//
//                }
//        }
//    }
    
    func getClinics(radius: Double, longitude: Double , latitude: Double, completion: @escaping (_ result: [Clinic])->()){
        
        
        let radiuz = radius != 0 ? "&radius=\(radius)" : ""
        
        print("https://mp3cloud.ru/dentallapp/clinics.php?latitude=\(latitude)&longitude=\(longitude)\(radiuz)")
        Alamofire.request("https://mp3cloud.ru/dentallapp/clinics.php?latitude=\(latitude)&longitude=\(longitude)\(radiuz)",
                          method: .get).responseJSON {
                            response in
                            if let clinics = Mapper<Clinic>().mapArray(JSONObject:response.result.value){
                                completion(clinics)
                                
                            }
        }
    }
    
    func getClinicWithId(id: Int, completion: @escaping (_ result: Clinic)->()){
        
        print("request : https://mp3cloud.ru/dentallapp/clinics.php?idClinic=\(id) ")
        Alamofire.request("https://mp3cloud.ru/dentallapp/clinics.php?idClinic=\(id)",
            method: .get).responseJSON {
                response in
                if let clinic = Mapper<Clinic>().map(JSONObject:response.result.value){
                    completion(clinic)
                    
                }
        }
    }

}
