//
//  MainTabBarController.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 15/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let mapCoordinator = MapCoordinator(navigationController: UINavigationController())
    //let searchCoordinator = SearchCoordinator(navigationController: UINavigationController())
    let sharesCoordinator = SharesCoordinator(navigationController: UINavigationController())
    let ratingsCoordinator = RatingsCoordinator(navigationController: UINavigationController())
    let commentsCoordinator = CommentsCoordinator(navigationController: UINavigationController())
    let servicesCoordinator = MedServicesCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItemsToViewControllers()
        startViewControllers()
        viewControllers = [mapCoordinator.navigationController,servicesCoordinator.navigationController,sharesCoordinator.navigationController,ratingsCoordinator.navigationController,commentsCoordinator.navigationController]
        self.tabBar.tintColor = UIColor.red
    }
    
    func startViewControllers(){
        mapCoordinator.start()
        servicesCoordinator.start()
        //searchCoordinator.start()
        sharesCoordinator.start()
        ratingsCoordinator.start()
        commentsCoordinator.start()
    }
    
    func setTabBarItemsToViewControllers(){
        mapCoordinator.setTabBarItem()
        servicesCoordinator.setTabBarItem()
        //searchCoordinator.setTabBarItem()
        sharesCoordinator.setTabBarItem()
        ratingsCoordinator.setTabBarItem()
        commentsCoordinator.setTabBarItem()
    }
    
    
}
