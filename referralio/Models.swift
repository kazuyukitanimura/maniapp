//
//  Models.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 4/18/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit
import Realm

struct Models {
  typealias NotificationToken = RLMNotificationToken

  // Get the default Realm
  static let REALM = RLMRealm.defaultRealm()
  private static var me: Profile!
  private static var draftMe: Profile!

  static func setup() {
    RLMRealm.setDefaultRealmSchemaVersion(10, withMigrationBlock: {migration, oldSchemaVersion in
      // do nothing here, auto migration
    })
    //println(REALM.path)
    Models.REALM.transactionWithBlock({ () -> Void in
      self.me = Profile.createOrUpdateInDefaultRealmWithObject([Profile.primaryKey()!: "me"])
      self.draftMe = Profile.createOrUpdateInDefaultRealmWithObject([Profile.primaryKey()!: "draftMe"])
    })
    if TARGET_IPHONE_SIMULATOR == 1 { // delete db for simulator
      REALM.transactionWithBlock({ () -> Void in
        self.REALM.deleteAllObjects()
      })
    }
  }

  static var count:UInt {
    get {
      return Profile.allObjects().count
    }
  }

  static func hasProfile(rowId: UInt, count: UInt = count) -> Bool {
    return (count > rowId) // TODO think the deleting profile case
  }

  static func createOrUpdate(object: AnyObject!) {
    Models.REALM.transactionWithBlock({ () -> Void in
      Profile.createOrUpdateInDefaultRealmWithObject(object)
    })
  }

  static func getProfile(rowId: UInt) -> Profile {
    let profiles = Profile.allObjects()
    if !hasProfile(rowId, count: profiles.count) {
      return Profile()
    }
    return profiles[rowId] as! Profile
  }

  static func getMe() -> Profile {
    return me
  }

  static func getDraftMe() -> Profile {
    return draftMe
  }
}


class Profile: RLMObject {
  dynamic var facebookID = ""
  dynamic var firstName = ""
  dynamic var lastName = ""
  dynamic var currentAffiliation = ""
  dynamic var currentTitle = ""
  dynamic var currentLocation = ""
  dynamic var willingToRelocate = ""
  dynamic var minCashComensation = ""
  dynamic var minEquityComensation = ""
  dynamic var targetCompanySize = ""
  dynamic var thankYouTip = ""
  dynamic var dreamCompanies = ""
  dynamic var lookingFor = ""
  dynamic var skills = ""
  dynamic var blog = ""
  dynamic var github = ""
  dynamic var photo:NSData! = NSData()
  dynamic var email = ""
  dynamic var distance = 0 // myself is 0, direct friend is 1

  override static func primaryKey() -> String? {
    return "facebookID"
  }
}
