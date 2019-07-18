//
//  UIStoryboard.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 15/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

extension UIStoryboard{
    
    static func load<T: UIViewController>(_ name: StoryboardName) -> T{
        return UIStoryboard(name: name.rawValue, bundle: nil).instantiateInitialViewController() as! T
    }
    
    static func load<T: UIViewController>(_ name: StoryboardName, with identifier: String) -> T {
        return UIStoryboard(name: name.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as! T
    }
}
