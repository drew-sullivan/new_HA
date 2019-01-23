//
//  AppDelegate.swift
//  Drew_Sullivan_HA_iOS_Project
//
//  Created by Drew Sullivan on 12/27/18.
//  Copyright © 2018 Drew Sullivan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let proStore = ProStore()
        
        let navController = window!.rootViewController as! UINavigationController
        let prosViewController = navController.topViewController as! ProsTableViewController
        prosViewController.proStore = proStore
        return true
    }
}
