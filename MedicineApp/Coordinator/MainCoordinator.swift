//
//  NavigationCoordinator.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 17/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit
import Foundation

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CountryViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func firstStart(){
        
        let defaults = UserDefaults.standard
        
        if((defaults.string(forKey: "City") == nil) || (defaults.string(forKey: "Region") == nil)){
            let locationManager = LocationServices.instance
            let countryVC = CountryViewController.instantiate()
            countryVC.coordinator = self
            locationManager.delegate = countryVC
            countryVC.navigationItem.title = "Город"
            navigationController.pushViewController(countryVC, animated: false)
        }else{
            let homeVC = HomeViewController.instantiate()
            homeVC.coordinator = self
            navigationController.pushViewController(homeVC, animated: false)
        }
    }
}
