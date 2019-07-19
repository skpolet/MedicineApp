//
//  CommentsCoordinator.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 18/07/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit

class CommentsCoordinator: Coordinator{
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    let comments = CommentsBuilder()
    
    func start() {
        comments.vc?.coordinator = self
        navigationController.pushViewController(comments.vc!, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: UITabBarItem
    
    func setTabBarItem(){
        comments.vc?.tabBarItem = UITabBarItem(title: "Комментарии", image: UIImage(named: "chat"), tag: 5)
    }
    
}
