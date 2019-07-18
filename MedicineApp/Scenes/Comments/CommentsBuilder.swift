//
//  Comments.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

class CommentsBuilder{
    weak var vc : CommentsViewController?
    
    init() {
        vc  = UIStoryboard.load(.comments, with: String(describing: CommentsViewController.self))
    }
}
