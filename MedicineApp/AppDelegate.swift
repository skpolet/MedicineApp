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

