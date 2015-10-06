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
import CryptoSwift

class Config {
    private static let TOKEN_SEED = "0fe95477-d64c-4e0d-a60d-956333d549e"
    
    
    private class func sha256(data: NSData) -> NSData {
        return CryptoSwift.Hash.md5(data).calculate()!
    }
    
    /*
    private class func sha256(data : NSData) -> NSData {
        var hash = [UInt8](count: Int(CC_SHA256_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA256(data.bytes, CC_LONG(data.length), &hash)
        let res = NSData(bytes: hash, length: Int(CC_SHA256_DIGEST_LENGTH))
        return res
    }
    */
    
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
        
        let urlSession = NSURLSession.sharedSession()
        urlSession.dataTaskWithURL(NSURL(string: "http://www.timeapi.org/utc/now")!, completionHandler: { (data, rsp, error) -> Void in
            if error != nil {
                callback(nil, nil)
            } else {
                let dateFormatter = NSDateFormatter()
                dateFormatter.timeZone = NSTimeZone(name: "UTC")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'+00:00'"
                
                let rspString = NSString(data: data!, encoding: NSASCIIStringEncoding)
                let dateNow = dateFormatter.dateFromString(rspString! as String)
                if dateNow == nil {
                    callback(nil, nil)
                } else {
                    let dateOneMinuteEarlier = NSDate(timeInterval: -60.0, sinceDate: dateNow!)
                    callback(getStringForDate(dateOneMinuteEarlier), getStringForDate(dateNow!))
                }
            }
        }).resume()
        
        
    }
    
    class func tokenForCurrentTime(callback: (String?, String?)->Void) {
        
        getCurrentTimeStrings({(minuteEarly:String?, now: String?) in
            if minuteEarly == nil {
                callback(nil, nil)
            } else {
                let dataEarly = sha256("\(TOKEN_SEED)-\(minuteEarly!)".dataUsingEncoding(NSASCIIStringEncoding)!)
                let dataNow = sha256("\(TOKEN_SEED)-\(now!)".dataUsingEncoding(NSASCIIStringEncoding)!)
                callback(NSString(data: dataEarly, encoding: NSASCIIStringEncoding) as? String
                , NSString(data: dataNow, encoding: NSASCIIStringEncoding) as? String)
            }
        })
    }
}
