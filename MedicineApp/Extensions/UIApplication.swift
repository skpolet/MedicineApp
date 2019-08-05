//
//  UIApplication.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 05/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit

// MARK: UIApplication extensions

extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
