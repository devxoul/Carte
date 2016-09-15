//
//  ViewController.swift
//  CarteDemo
//
//  Created by 전수열 on 8/4/15.
//  Copyright (c) 2015 Suyeol Jeon. All rights reserved.
//

import Carte
import UIKit

final class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Carte Demo"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "\u{2699}",
      style: .plain,
      target: self,
      action: #selector(settingsDidTap)
    )
  }

  func settingsDidTap() {
    let carteViewController = CarteViewController()
    let navigationController = UINavigationController(rootViewController: carteViewController)
    self.present(navigationController, animated: true)
  }

}
