//
//  ViewController.swift
//  AppUnderControl-Bridge
//
//  Created by Fabian Schuetz on 10/05/2015.
//  Copyright (c) 2015 Fabian Schuetz. All rights reserved.
//

import UIKit
import AppUnderControl_Bridge

class InitialViewController: UIViewController {
    
    
    @IBAction func onStart(sender: AnyObject) {
        AppUnderControlTools.requestURLPermission("example://", withName: "MyExample", andSeed: (UIApplication.sharedApplication().delegate as! AppUnderControlDelegate).appUnderControlGetTokenSeed())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

