//
//  CountryViewManager.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation

protocol Alertable {
    func issueAlert()
}

extension Alertable where Self: CountryViewController {
    func issueAlert() {
        // alert code here
    }
}
