//
//  SplashBuilder.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 15/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class SplashBuilder{
    weak var vc : SplashViewController?
    
    init() {
        vc  = UIStoryboard.load(.splash, with: String(describing: SplashViewController.self))
    }
}
