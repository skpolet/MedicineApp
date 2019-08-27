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
        let mapViewModel = MapViewModel()
        let locationServices = LocationServices.instance
        locationServices.delegate = mapViewModel
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController.pushViewController(self.tabbar, animated: false)
            self.navigationController.isNavigationBarHidden = true
            self.tabbar.navigationItem.hidesBackButton = true
        }
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
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
    
}

