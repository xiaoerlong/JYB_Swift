//
//  AppDelegate.swift
//  JYB_Swift
//
//  Created by kim on 2020/12/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = JYBTestViewController()
        window?.makeKeyAndVisible()
        
        AppTheme.manager.setLastedTheme()
        AppManager.manager.saveVersion()
        
        return true
    }
}

