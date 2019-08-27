//
//  ClinicInfoTransition.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 07/08/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol HandleDelegate: class {
    
    func handlePan(sender: UIPanGestureRecognizer)
}

class ClinicTransitionableView: UIView{
    
    
    var delegate: HandleDelegate?
    
    init() {
        // frame is set later if needed by creator when using this init method
        super.init(frame: CGRect.zero)
        configureGestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGestureRecognizers()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGestureRecognizers()
    }
    
    // setup UIPanGestureRecognizer
    internal func configureGestureRecognizers() {
        let panGR = UIPanGestureRecognizer.init(target: self, action: #selector(didPan(_:)))
        addGestureRecognizer(panGR)
    }
    
    @objc func didPan(_ panGR: UIPanGestureRecognizer) {

        delegate?.handlePan(sender: panGR)

    }
    

}
