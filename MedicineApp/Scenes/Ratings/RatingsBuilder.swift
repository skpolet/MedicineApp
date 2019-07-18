//
//  RatingsBuilder.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

class RatingsBuilder{
    weak var vc : RatingsViewController?
    
    init() {
        vc  = UIStoryboard.load(.ratings, with: String(describing: RatingsViewController.self))
    }
}
