//
//  MainCoordinator.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 15/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate{
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var fromCoordinator: Coordinator?
    
    let splash = SplashBuilder()
    
    let tabbar = MainTabBarController()
    
    func start() {
        splash.vc?.coordinator = self
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController.pushViewController(self.tabbar, animated: false)
            self.tabbar.navigationItem.hidesBackButton = true
        }
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
//    func callSearchCoordinator(){
//        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
//        fromCoordinator = searchCoordinator
//        searchCoordinator.parentCoordinator = self
//        childCoordinators.append(searchCoordinator)
//        searchCoordinator.start()
//
//    }
//
//    func callMapCoordinator(){
//        let mapCoordinator = MapCoordinator(navigationController: navigationController)
//        fromCoordinator = mapCoordinator
//        mapCoordinator.parentCoordinator = self
//        childCoordinators.append(mapCoordinator)
//        mapCoordinator.start()
//
//    }
    
    func childDidFinish(_ child: Coordinator?){
        for (index, coordinator) in childCoordinators.enumerated(){
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func setFromCoordinator(coordinator: Coordinator){
        self.fromCoordinator = coordinator
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController){ return }
        
        
        if let childCoordinator = fromCoordinator {
            childDidFinish(childCoordinator)
        }
    }
    
    // MARK: UITabBarItem
    
//    func setTabBarItem(){
//        splash.vc?.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
//    }
    
}

