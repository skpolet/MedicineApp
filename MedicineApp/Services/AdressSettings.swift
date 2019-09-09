//
//  AdressSettings.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 08/09/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation

enum Adress: String{
    
    case domain //= "моястоматология.рус"
    case versionAPI //= "apiv1"
    
    func value () -> String {
        switch self {
        case .domain:
            return "xn--80agpkdanacb1amd0pla.xn--p1acf"
        case .versionAPI:
            return "apiv1"
        }
    }
}
