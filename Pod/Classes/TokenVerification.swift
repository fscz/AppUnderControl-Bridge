//
//  Config.swift
//  AppUnderControl
//
//  Created by Fabian Schuetz on 01/10/15.
//  Copyright © 2015 Lohmann & Birkner Mobile Services. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import SwiftyBase64
import CommonCrypto

class TokenVerification {
    
    /*
    private class func sha256(data: NSData) -> NSData {
        return CryptoSwift.Hash.sha256(data).calculate()!
    }*/
    
    
    private class func sha256(data : NSData) -> NSData {
        var hash = [UInt8](count: Int(CC_SHA256_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA256(data.bytes, CC_LONG(data.length), &hash)
        let res = NSData(bytes: hash, length: Int(CC_SHA256_DIGEST_LENGTH))
        return res
    }
    
    
    private class func getStringForDate(date: NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone(name: "UTC")!
        
        let components = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute], fromDate: date)
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        return "\(year)-\(month)-\(day)-\(hour)-\(minute)"
    }
    
    private class func getCurrentTimeStrings(callback: (String?, String?)->Void) {
        
        let dateNow = NSDate()
        let dateOneMinuteEarlier = NSDate(timeInterval: -60.0, sinceDate: dateNow)

        callback(getStringForDate(dateOneMinuteEarlier), getStringForDate(dateNow))
    }
    
    private class func getTokenSeed() -> String? {
        let appUnderControlDelegate = UIApplication.sharedApplication().delegate as? AppUnderControlDelegate
        let seed = appUnderControlDelegate?.appUnderControlGetTokenSeed()
        return seed
    }
    
    private class func tokensForCurrentTime(callback: ([String])->Void) {
        
        getCurrentTimeStrings({(minuteEarly:String?, now: String?) in
            if minuteEarly == nil {
                callback([])
            } else {
                if let seed = getTokenSeed() {
                    let dataEarly = sha256("\(seed)-\(minuteEarly!)".dataUsingEncoding(NSASCIIStringEncoding)!)
                    let dataNow = sha256("\(seed)-\(now!)".dataUsingEncoding(NSASCIIStringEncoding)!)
                    
                    let countEarly = dataEarly.length / sizeof(UInt8)
                    let countNow = dataNow.length / sizeof(UInt8)
                    
                    var arrayEarly = [UInt8](count: countEarly, repeatedValue: 0)
                    dataEarly.getBytes(&arrayEarly, length: dataEarly.length / sizeof(UInt8) * sizeof(UInt8))
                    
                    var arrayNow = [UInt8](count: countNow, repeatedValue: 0)
                    dataNow.getBytes(&arrayNow, length: dataNow.length / sizeof(UInt8) * sizeof(UInt8))
                    
                    
                    callback([
                        SwiftyBase64.EncodeString(arrayEarly, alphabet: .URLAndFilenameSafe),
                        SwiftyBase64.EncodeString(arrayNow, alphabet: .URLAndFilenameSafe)
                        ])
                } else {
                    callback([])
                }
                
            }
        })
    }
    
    class func verfifyOpenUrl(app: AppUnderControlDelegate, openURL: NSURL) {
        let array = openURL.description.componentsSeparatedByString("%23")
        if array.count == 2 {
            
            let tokenEncoded = array[1]
            
            TokenVerification.tokensForCurrentTime({ (tokens) -> Void in
                if tokens.contains(tokenEncoded as String) {
                    app.appUnderControl(app, didReceiveValidToken: tokenEncoded)
                }
            })
        }
    }
}
