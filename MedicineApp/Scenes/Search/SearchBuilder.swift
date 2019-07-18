//
//  SearchBuilder.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 15/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class SearchBuilder{
    weak var vc : SearchViewController?
    
    init() {
        vc  = UIStoryboard.load(.search, with: String(describing: SearchViewController.self))
    }
}
