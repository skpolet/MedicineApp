//
//  MedServicesCoordinator.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 19/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class MedServicesCoordinator: Coordinator{
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    let services = MedServicesBuilder()
    
    func start() {
        services.vc?.coordinator = self
        navigationController.pushViewController(services.vc!, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: UITabBarItem
    
    func setTabBarItem(){
        services.vc?.tabBarItem = UITabBarItem(title: "Услуги", image: UIImage(named: "clipboard"), tag: 5)
    }
    
}
