//
//  AppDelegate.swift
//  BookStore_Filipe
//
//  Created by FAP on 20/07/21.
//  Copyright © 2021 Filipe Souza. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BookListRouter.createModule()
        window?.makeKeyAndVisible()
        
        return true
    }

}

