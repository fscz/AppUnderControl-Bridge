//
//  AppDelegate.swift
//  AppUnderControl-Bridge
//
//  Created by Fabian Schuetz on 10/05/2015.
//  Copyright (c) 2015 Fabian Schuetz. All rights reserved.
//

import UIKit
import AppUnderControl_Bridge

@UIApplicationMain
class AppDelegate: AppUnderControlDelegate {

    /**
     You can AND SHOULD override this method to return your
     own private seed.
    **/
    override func appUnderControlGetTokenSeed() -> String {
        return "0fe95477-d64c-4e0d-a60d-956333d549e"
    }
    
    /**
     This method is called, once permission to start has been granted on a paired AppleWatch.
    **/
    override func appUnderControl(app: AppUnderControlDelegate, didReceiveValidToken: String) {
        super.appUnderControl(app, didReceiveValidToken: didReceiveValidToken)
        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Start")
    }

    /**
     Reset application state 
    **/
    override func applicationWillEnterForeground(application: UIApplication) {
        super.applicationWillEnterForeground(application)
        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }

}

