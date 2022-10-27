//
//  AppDelegate.swift
//  StructureTreeApp
//
//  Created by Андрей Антонов on 27.10.2022.
//  Copyright © 2022 Андрей Антонов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let listNodeViewController = ListNodesViewController()
        let navController = UINavigationController()
        
        navController.viewControllers = [listNodeViewController]
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

