//
//  MedServicesBuilder.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 19/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

class MedServicesBuilder{
    weak var vc : MedServicesViewController?
    
    init() {
        vc  = UIStoryboard.load(.services, with: String(describing: MedServicesViewController.self))
    }
}
