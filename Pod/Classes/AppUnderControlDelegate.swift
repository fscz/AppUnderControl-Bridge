//
//  AppUnderControlDelegate.swift
//  MyApp
//
//  Created by Fabian Schuetz on 05/10/15.
//  Copyright © 2015 Lohmann & Birkner Mobile Services. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppUnderControlDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    class func appUnderControl(requestURLPermission: String, withName: String, andSeed: String) {
        UIApplication.sharedApplication().openURL(NSURL(string: "appundercontrol://#\(withName)#\(requestURLPermission)#\(andSeed)")!)
    }
    
    func appUnderControl(app: AppUnderControlDelegate, didReceiveValidToken: String) {
        
    }
    
    // "#callbackScheme://#token"
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let urlString = url.description
        let array = urlString.substringFromIndex(urlString.startIndex.advancedBy(13)).componentsSeparatedByString("#")
        if array.count == 2 {
            
            let token = array[1]
            
            if token == "" {
                appUnderControl(self, didReceiveValidToken: token)
            }
        }
        return false
    }
    
    func application(application: UIApplication, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]?) -> Void)) {
        UIApplication.sharedApplication().openURL(NSURL(string: userInfo!["url"] as! String)!)
        reply([NSObject : AnyObject]())
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

