//
//  LoginViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 3/26/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, UIGestureRecognizerDelegate, FBSDKLoginButtonDelegate {
  let colorTop = AppColors.Yellow.CGColor
  let colorBottom = AppColors.Orange.CGColor
  let backgroundGradient = CAGradientLayer()
  private let LOGGEDIN = "LOGGEDIN"

  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundGradient.colors = [colorTop, colorBottom]
    backgroundGradient.locations = [0.0, 1.0]
    backgroundGradient.frame = view.frame
    view.layer.insertSublayer(backgroundGradient, atIndex: 0)
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTapGesture:"))
    let loginButton = FBSDKLoginButton()
    loginButton.delegate = self
    loginButton.center = view.center
    view.addSubview(loginButton)
  }

  func handleTapGesture(recognizer: UITapGestureRecognizer) {
    view.removeFromSuperview()
    kvStore(LOGGEDIN, true)
  }

  func isLoggedIn() -> Bool {
    return kvLoad(LOGGEDIN) as? Bool ?? false
  }

  func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    if (error != nil) {
      // alert error
      return
    } else if (result.declinedPermissions.count > 0) {
      // logout for declined permissions
      loginButtonDidLogOut(loginButton)
      return
    } else if (result.isCancelled) {
      // do nothing
      return
    }
    // FIXME This will be called after authentication is checked...
    kvStore(LOGGEDIN, true)
  }

  func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    kvStore(LOGGEDIN, false)
  }
}