//
//  CommentsLoader.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 29/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class CommentLoader{

func getCommentWithId(id: Int, completion: @escaping (_ result: Comment)->()){
    
    //print("request : https://\(Adress.domain.value())/\(Adress.versionAPI.value())/comments.php?idComment=\(id)")
    Alamofire.request("https://\(Adress.domain.value())/\(Adress.versionAPI.value())/comments.php?idComment=\(id)",
        method: .get).responseJSON {
            response in
            if let comment = Mapper<Comment>().map(JSONObject:response.result.value){
                completion(comment)
                
            }
    }
}

func getComments(idClinic: Int, completion: @escaping (_ result: [Comment])->()){
    
    //print("request : https://\(Adress.domain.value())/\(Adress.versionAPI.value())/comments.php?idClinic=\(idClinic)")
    Alamofire.request("https://\(Adress.domain.value())/\(Adress.versionAPI.value())/comments.php?idClinic=\(idClinic)",
        method: .get).responseJSON {
            response in
            if let comment = Mapper<Comment>().mapArray(JSONObject:response.result.value){
                completion(comment)
                
            }
    }
}

}
