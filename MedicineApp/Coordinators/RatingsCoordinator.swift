//
//  RatingsCoordinator.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class RatingsCoordinator: Coordinator{
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    let ratings = RatingsBuilder()
    
    func start() {
        ratings.vc?.coordinator = self
        navigationController.pushViewController(ratings.vc!, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: UITabBarItem
    
    func setTabBarItem(){
        ratings.vc?.tabBarItem = UITabBarItem(title: "Рейтинги", image: UIImage(named: "podium"), tag: 5)

    }
    
}
