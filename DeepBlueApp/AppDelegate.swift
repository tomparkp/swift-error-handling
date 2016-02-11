//
//  AppDelegate.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import UIKit
import Raven

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupRaven()
        return true
    }

    func setupRaven() {
        let ravenClient = RavenClient(DSN: "https://4954fcf42a03498d8ec0ad4a8df6019a:a03c97140d2c493a8e3148d4fb2f2d40@app.getsentry.com/66874")
        RavenClient.setSharedClient(ravenClient)
    }
}

