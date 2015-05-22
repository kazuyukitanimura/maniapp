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
  private let colorTop = AppColors.Yellow.CGColor
  private let colorBottom = AppColors.Orange.CGColor
  private let backgroundGradient = CAGradientLayer()
  // TODO create a better loading indicator
  private let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
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
    let constrainedViews = ConstrainedViews(views: [
      "title": [
        "text": "Referral I/O",
        "font": AppFonts.logoFont,
        "textColor": AppColors.White,
        "textAlignment": NSTextAlignment.Center.rawValue,
      ],
      "loginButton": loginButton,
    ], formats:["H:|-[title]-|", "H:|-\(bigPad)-[loginButton]-\(bigPad)-|", "V:|-229-[title]-(>=\(bigPad))-[loginButton(\(bigPad * 2))]-229-|"])
    view.addConstrainedViews(constrainedViews)
    FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "onProfileUpdated:", name: FBSDKProfileDidChangeNotification, object: nil)
    activityView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    activityView.center = view.center
    activityView.startAnimating()
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    activityView.removeFromSuperview()
  }

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    removeFromParentViewController()
  }

  func isLoggedIn() -> Bool {
    if TARGET_IPHONE_SIMULATOR == 1 { // skip authentication for debugging
      return true
    }
    return kvLoad(LOGGEDIN) as? Bool ?? false
  }

  func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    view.addSubview(activityView)
    if (error != nil) {
      // alert error
      var alert = UIAlertController(title: error.localizedDescription, message: "Please check the network connection", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      return
    } else if (result.isCancelled) {
      // do nothing
      return
    } else if (result.declinedPermissions.count > 0) {
      // logout for declined permissions
      logout()
      return
    }
    view.addSubview(ReferralViewController().view)
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
    var me = Models.getMe()
    var draftMe = Models.getDraftMe()

    // need to register notification first before changing models
    notificationToken = Models.REALM.addNotificationBlock { notification, realm in
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        NSNotificationCenter.defaultCenter().postNotificationName("loadData", object: nil) // TODO change to delegate?
        Models.REALM.removeNotification(self.notificationToken)
        self.activityView.removeFromSuperview()
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
        let imageUrl = self.FB_GRAPH_API_PREFIX + currentProfile.imagePathForPictureMode(.Square, size: CGSizeMake(160, 160))
        let imageData = NSData(contentsOfURL: NSURL(string: imageUrl)!) // TODO this is a blocking call
        if (draftMe.photo.length == 0) {
          draftMe.photo = imageData
        }
        me.photo = imageData
      }
    })
  }
}