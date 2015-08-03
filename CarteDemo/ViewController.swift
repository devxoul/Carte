//
//  ViewController.swift
//  CarteDemo
//
//  Created by 전수열 on 8/4/15.
//  Copyright (c) 2015 Suyeol Jeon. All rights reserved.
//

import Carte
import UIKit

public class ViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Carte Demo"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "\u{2699}",
            style: .Plain,
            target: self,
            action: "settingsDidTap"
        )
    }

    public func settingsDidTap() {
        let item = CarteItem()
        item.name = "Carte"
        item.version = "1.0.0"
        item.licenseName = "MIT"
        item.licenseText = "Hello, World!"

        let carteViewController = CarteViewController()
        carteViewController.items.append(item)

        let navigationController = UINavigationController(rootViewController: carteViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }

}
