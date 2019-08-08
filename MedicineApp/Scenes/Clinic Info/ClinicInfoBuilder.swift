//
//  ClinicInfoBuilder.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 06/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

class ClinicInfoBuilder{
    weak var vc : ClinicInfoViewController?
    
    init() {
        vc  = UIStoryboard.load(.clinicInfo, with: String(describing: ClinicInfoViewController.self))
    }
}
