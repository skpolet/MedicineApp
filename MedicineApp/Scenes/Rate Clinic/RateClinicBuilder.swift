//
//  RateClinicBuilder.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 08/09/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

class RateClinicBuilder{
    var vc : RateClinicViewController?
    
    init() {
        vc  = UIStoryboard.load(.rateClinic, with: String(describing: RateClinicViewController.self))
    }
}
