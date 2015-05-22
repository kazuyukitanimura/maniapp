//
//  ReferralViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 5/19/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ReferralViewController: UIViewController {
  // XXX /me/friends works only for who uses this app already
  // http://stackoverflow.com/questions/29428478/facebook-friends-list-api-for-swift-ios
  let friendsRequest = FBSDKGraphRequest(graphPath: "/me/taggable_friends", parameters: nil)

  override func viewDidLoad() {
    super.viewDidLoad()

    friendsRequest.startWithCompletionHandler({(connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
      if (error != nil) {
        println("Error Getting Friends \(error)")
        return
      }
      if let resultdict = result as? NSDictionary {
        if let data = resultdict["data"] as? NSArray {
          for datum in data {
            if let valueDict = datum as? NSDictionary {
              if let name = valueDict["name"] as? String {
                println(name)
              }
            }
          }
        }
      }
    })
  }
}