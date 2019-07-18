//
//  AppDelegate.swift
//  MedicineApp
//
//  Created by Sergey Mikhailov on 07/06/2019.
//  Copyright © 2019 Medicine App. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

//        let navController = UINavigationController()
//        
        // Подключаем ключи апи гугл карт и локаций
        GMSServices.provideAPIKey("AIzaSyDZARmmMu8nnyW5SP3XeeASajhd08QK4q4")
        GMSPlacesClient.provideAPIKey("AIzaSyDZARmmMu8nnyW5SP3XeeASajhd08QK4q4")
        
        initWithSplash()
        //setupForTabBarController()
//        // send that into our coordinator so that it can display view controllers
//        coordinator = MainCoordinator(navigationController: navController)
//        
//        // tell the coordinator to take over control
//        coordinator?.firstStart()
//        
//        // create a basic UIWindow and activate it
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
        return true
    }
    
    // MARK: Initial Coordinator Setup
    
    func initWithSplash(){
        let splash = SplashBuilder()
        let startVC = UINavigationController(rootViewController: splash.vc!)
        let mainCoordinator = MainCoordinator(navigationController: startVC)
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = startVC
        window?.makeKeyAndVisible()
        mainCoordinator.start()
    }
    
    func setupForTabBarController(){
        // create a basic UIWindow and activate it
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }

}

