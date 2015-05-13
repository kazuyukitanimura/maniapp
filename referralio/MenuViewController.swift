//
//  MenuViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 3/25/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class MenuViewController: UIViewController {
  let loginButton = FBSDKLoginButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = AppColors.Black
    loginButton.readPermissions = ["public_profile", "email", "user_friends"]
    let constrainedViews = ConstrainedViews(views: ["loginButton": loginButton], formats:["H:|-(>=16)-[loginButton]-16-|", "V:|-64-[loginButton]-(>=32)-|"])
    view.addConstrainedViews(constrainedViews)
  }

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    removeFromParentViewController()
  }
}