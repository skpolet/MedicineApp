//
//  SharesCoordinator.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class SharesCoordinator: Coordinator{
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    let shares = SharesBuilder()
    
    func start() {
        shares.vc?.coordinator = self
        navigationController.pushViewController(shares.vc!, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: UITabBarItem
    
    func setTabBarItem(){
        //shares.vc?.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        self.navigationController.tabBarItem.title = "Отзывы"
    }
    
}
