//
//  AppDelegate.swift
//  CarteDemo
//
//  Created by 전수열 on 8/4/15.
//  Copyright (c) 2015 Suyeol Jeon. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window!.backgroundColor = UIColor.white
    self.window!.rootViewController = UINavigationController(rootViewController: ViewController())
    self.window!.makeKeyAndVisible()
    return true
  }
  
}
