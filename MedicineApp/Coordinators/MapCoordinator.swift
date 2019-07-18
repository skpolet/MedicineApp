//
//  MapCoordinator.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class MapCoordinator: Coordinator{
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    let mapVC = MapBuilder()
    
    func start() {
        mapVC.vc?.coordinator = self
        navigationController.pushViewController(mapVC.vc!, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: UITabBarItem
    
    func setTabBarItem(){
        //mapVC.vc?.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        self.navigationController.tabBarItem.title = "Клиники"
    }
    
}
