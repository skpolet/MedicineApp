//
//  SharesBuilder.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

class SharesBuilder{
    weak var vc : SharesViewController?
    
    init() {
        vc  = UIStoryboard.load(.shares, with: String(describing: SharesViewController.self))
    }
}
