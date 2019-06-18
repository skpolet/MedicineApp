//
//  Coordinator.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 17/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

