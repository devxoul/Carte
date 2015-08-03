//
//  AppDelegate.swift
//  CarteDemo
//
//  Created by 전수열 on 8/4/15.
//  Copyright (c) 2015 Suyeol Jeon. All rights reserved.
//

import UIKit

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?

    public func application(application: UIApplication,
                            didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window!.makeKeyAndVisible()
        return true
    }

}