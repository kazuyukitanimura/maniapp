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
  private let tutorialViewController = TutorialViewController()

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
      "tutorial": tutorialViewController,
      "loginButton": loginButton,
    ], formats:[
      "H:|-0-[title]-0-|",
      "H:|-0-[tutorial]-0-|",
      "H:|-\(AppPaddings.oneHalf)-[loginButton]-\(AppPaddings.oneHalf)-|",
      "V:|-229-[title]-(>=\(AppPaddings.oneHalf))-[tutorial]-\(AppPaddings.triple)-[loginButton(\(AppPaddings.triple))]-129-|",
    ])
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
      presentViewController(alert, animated: true, completion: nil)
      return
    } else if (result.isCancelled) {
      // do nothing
      return
    } else if (result.declinedPermissions.count > 0) {
      // logout for declined permissions
      logout()
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
    importFacebookFriends()
  }

  func importFacebookFriends(var after: String = "") {
    if TARGET_IPHONE_SIMULATOR == 1 { // skip friend request for simulators
      return
    }
    // XXX /me/friends works only for who uses this app already
    // http://stackoverflow.com/questions/29428478/facebook-friends-list-api-for-swift-ios
    let parameters = [
      "fields": "first_name,last_name,picture",
      "limit": "20",
      "after": after,
    ]
    let friendsRequest = FBSDKGraphRequest(graphPath: "/me/taggable_friends", parameters: parameters)
    // XXX we cannot run this in background threads
    friendsRequest.startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
      if (error != nil) {
        println("Error Getting Friends \(error)")
        return
      }
      if let resultdict = result as? NSDictionary {
        if let data = resultdict["data"] as? NSArray {
          Models.REALM.transactionWithBlock({ () -> Void in
            for datum in data {
              if let valueDict = datum as? NSDictionary {
                let picture = (valueDict["picture"] ?? NSDictionary()) as! NSDictionary
                let pictureData = (picture["data"] ?? NSDictionary()) as! NSDictionary
                let imageUrl = (pictureData["url"] ?? "") as! String
                let profileObject:[String: AnyObject!] = [
                  Profile.primaryKey()!: (valueDict["id"] ?? "") as! String, // XXX this id changes everytime
                  "firstName": (valueDict["first_name"] ?? "") as! String,
                  "lastName": (valueDict["last_name"] ?? "") as! String,
                  "photo": NSData(contentsOfURL: NSURL(string: imageUrl)!), // TODO this is a blocking call
                ]
                Models.createOrUpdate(profileObject)
              }
            }
          })
        }
        if let paging = resultdict["paging"] as? NSDictionary {
          if let cursors = paging["cursors"] as? NSDictionary {
            after = (cursors["after"] ?? "") as! String
            if (!after.isEmpty) {
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.importFacebookFriends(after: after)
              })
            }
          }
        }
      }
    })
  }
}