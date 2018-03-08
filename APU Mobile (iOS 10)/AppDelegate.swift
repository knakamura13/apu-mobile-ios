//
//  AppDelegate.swift
//  APU Mobile (iOS 10)
//
//  Created by Kyle Nakamura (Student) on 6/12/17.
//  Copyright © 2017 Kyle Nakamura (Student). All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case "kyle":
            globalUrl = "https://mobile-kyle.apu.edu"
            break;
        case "monte":
            globalUrl = "https://mobile-monte.apu.edu"
            break;
        case "test":
            globalUrl = "https://mobile-test.apu.edu"
            break;
        case "beta":
            globalUrl = "https://mobile-beta.apu.edu"
            break;
        default:
            globalUrl = "https://mobile.apu.edu"
            break;
        }
        performQuickSegue(destinationVC: "quickSegueVC")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if globalUrl != "https://mobile.apu.edu" {
            globalUrl = "https://mobile.apu.edu"
            performQuickSegue(destinationVC: "quickSegueVC")
        }
    }
    
    // Access the storyboard and fetch an instance of the view controller
    // Then push that view controller onto the navigation stack
    func performQuickSegue(destinationVC: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: quickSegueVC = storyboard.instantiateViewController(withIdentifier: destinationVC) as! quickSegueVC
        let rootViewController = self.window!.rootViewController as! UINavigationController
        rootViewController.pushViewController(viewController, animated: true)
    }
}
