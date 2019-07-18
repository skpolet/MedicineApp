//
//  MapBuilder.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 15/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class MapBuilder{
    weak var vc : MapViewController?
    
    init() {
        vc  = UIStoryboard.load(.map, with: String(describing: MapViewController.self))
    }
}
