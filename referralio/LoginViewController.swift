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

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
  let colorTop = AppColors.Yellow.CGColor
  let colorBottom = AppColors.Orange.CGColor
  let backgroundGradient = CAGradientLayer()
  private let LOGGEDIN = "LOGGEDIN"
  private let FB_GRAPH_API_PREFIX = "https://graph.facebook.com/"
  private var notificationToken: Models.NotificationToken!

  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundGradient.colors = [colorTop, colorBottom]
    backgroundGradient.locations = [0.0, 1.0]
    backgroundGradient.frame = view.frame
    view.layer.insertSublayer(backgroundGradient, atIndex: 0)
    let loginButton = FBSDKLoginButton()
    loginButton.readPermissions = ["public_profile", "email", "user_friends"]
    loginButton.delegate = self
    loginButton.center = view.center
    view.addSubview(loginButton)
    FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "onProfileUpdated:", name: FBSDKProfileDidChangeNotification, object: nil)
  }

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    removeFromParentViewController()
  }

  func isLoggedIn() -> Bool {
    return kvLoad(LOGGEDIN) as? Bool ?? false
  }

  func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    if (error != nil) {
      // alert error
      var alert = UIAlertController(title: error.localizedDescription, message: "Please check the network connection", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      return
    } else if (result.declinedPermissions.count > 0) {
      // logout for declined permissions
      logout()
      return
    } else if (result.isCancelled) {
      // do nothing
      return
    }
    kvStore(LOGGEDIN, true)
  }

  func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    kvStore(LOGGEDIN, false)
  }

  func logout() {
    FBSDKLoginManager().logOut()
    kvStore(LOGGEDIN, false)
  }

  func onProfileUpdated(loginButton: FBSDKLoginButton!) {
    let currentProfile = FBSDKProfile.currentProfile()
    if (currentProfile == nil) {
      return
    }
    let imageUrl = FB_GRAPH_API_PREFIX + currentProfile.imagePathForPictureMode(.Square, size: CGSizeMake(160, 160))
    let imageData = NSData(contentsOfURL: NSURL(string: imageUrl)!)
    var me = Models.getMe()
    var draftMe = Models.getDraftMe()

    // need to register notification first before changing models
    notificationToken = Models.REALM.addNotificationBlock { notification, realm in
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        NSNotificationCenter.defaultCenter().postNotificationName("loadData", object: nil) // TODO change to delegate?
        Models.REALM.removeNotification(self.notificationToken)
      })
    }

    Models.REALM.transactionWithBlock({ () -> Void in
      if (me.firstName.isEmpty) {
        if (draftMe.firstName.isEmpty) {
          draftMe.firstName = currentProfile.firstName
        }
        me.firstName = currentProfile.firstName
      }
      if (me.lastName.isEmpty) {
        if (draftMe.lastName.isEmpty) {
          draftMe.lastName = currentProfile.lastName
        }
        me.lastName = currentProfile.lastName
      }
      if (me.photo.length == 0) {
        if (draftMe.photo.length == 0) {
          draftMe.photo = imageData
        }
        me.photo = imageData
      }
    })
  }
}