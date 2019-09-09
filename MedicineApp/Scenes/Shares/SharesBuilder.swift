//
//  SharesBuilder.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

enum ShareType{
    case onceShare
    case allShares
}

class SharesBuilder{
    weak var vc : SharesViewController?
    
    weak var oncevc : OnceShareViewController?
    
    init(type: ShareType) {
        if(type == .allShares){
        vc  = UIStoryboard.load(.shares, with: String(describing: SharesViewController.self))
        }else{
        oncevc  = UIStoryboard.load(.onceShare, with: String(describing: OnceShareViewController.self))
        }
    }
    
}
