//
//  AppUnderControlTools.swift
//  Pods
//
//  Created by Fabian Schuetz on 06/10/15.
//
//

public class AppUnderControlTools {
    public class func requestURLPermission(forUrl: String, withName: String, andSeed: String) {
        UIApplication.sharedApplication().openURL(NSURL(string: "appundercontrol://%23\(withName)%23\(forUrl)%23\(andSeed)")!)
    }
}