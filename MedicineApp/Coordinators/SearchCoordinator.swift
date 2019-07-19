//
//  SearchCoordinator.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 15/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

 class SearchCoordinator: Coordinator{
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    let searchVC = SearchBuilder()
    
    func start() {
        searchVC.vc?.coordinator = self
        navigationController.pushViewController(searchVC.vc!, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: UITabBarItem
    
    func setTabBarItem(){
        searchVC.vc?.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(named: "loupe"), tag: 2)
    }
    
}
