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
        self.navigationController.navigationBar.barTintColor = UIColor(red:0.89, green:0.44, blue:0.40, alpha:1.0)
    }
    
    func start() {
        let vc = CountryViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toHome(){
        let defaults = UserDefaults.standard
        let homeVC = HomeViewController.instantiate()
        homeVC.coordinator = self
        homeVC.navigationItem.title = defaults.string(forKey: "City")
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func firstStart(){
        
        let defaults = UserDefaults.standard
        
        if((defaults.string(forKey: "City") == nil) || (defaults.string(forKey: "Region") == nil)){
            let locationManager = LocationServices.instance
            let countryVC = CountryViewController.instantiate()
            countryVC.coordinator = self
            locationManager.delegate = countryVC
            countryVC.navigationItem.title = "Город"
            navigationController.pushViewController(countryVC, animated: true)
        }else{
            let homeVC = HomeViewController.instantiate()
            homeVC.coordinator = self
            homeVC.navigationItem.title = defaults.string(forKey: "City")
            navigationController.pushViewController(homeVC, animated: true)
        }
    }
}
