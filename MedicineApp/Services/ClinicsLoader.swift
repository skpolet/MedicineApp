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
    
    func getClinics(radius: Double, longitude: Double , latitude: Double, completion: @escaping (_ result: [Clinic], _ connectionStatus: ReachabilityStatus)->()){
        
        
        let radiuz = radius != 0 ? "&radius=\(radius)" : ""
        
        //print("https://\(Adress.domain.value())/\(Adress.versionAPI.value())/clinics.php?latitude=\(latitude)&longitude=\(longitude)\(radiuz)")
        Alamofire.request("https://\(Adress.domain.value())/\(Adress.versionAPI.value())/clinics.php?latitude=\(latitude)&longitude=\(longitude)\(radiuz)",
                          method: .get).responseJSON {
                            response in
                            //print("CLINICS:\(response)")
                            //print("status code:\(String(describing: response.response?.statusCode))")
                            let status = Reach().connectionStatus()
                            if let clinics = Mapper<Clinic>().mapArray(JSONObject:response.result.value){
                                
                                completion(clinics,status)
                                
                            }else{
                                completion([],status)
                            }
        }
    }
    
    func getClinicWithId(id: Int, completion: @escaping (_ result: Clinic, _ connectionStatus: ReachabilityStatus)->()){
        
        print("request : https://\(Adress.domain.value())/\(Adress.versionAPI.value())/clinics.php?idClinic=\(id) ")
        Alamofire.request("https://\(Adress.domain.value())/\(Adress.versionAPI.value())/clinics.php?idClinic=\(id)",
            method: .get).responseJSON {
                response in
                let status = Reach().connectionStatus()
                
                if let clinic = Mapper<Clinic>().map(JSONObject:response.result.value){
                    completion(clinic,status)
                    
                }else{
                    var nilClinic: Clinic?
                    nilClinic = nil
                    completion(nilClinic!,status)
                }
        }
    }
    
    func getImageForClinic(id: Int, completion: @escaping (_ result: DataResponse<Data>, _ connectionStatus: ReachabilityStatus)->()){
        
        
        Alamofire.request("https://\(Adress.domain.value())/\(Adress.versionAPI.value())/images/clinics/\(id).jpg", method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                let status = Reach().connectionStatus()
                completion(responseData,status)
            })
        
//        Alamofire.request("https://\(Adress.domain.value())/\(Adress.versionAPI.value())/images/clinics/\(id).jpg",
//            method: .get).responseData {
//                response in
//
//                let status = Reach().connectionStatus()
//                completion(response,status)
//
//        }
    }

}
