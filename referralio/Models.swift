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
  // Get the default Realm
  static let REALM = RLMRealm.defaultRealm()

  static func setup() {
    RLMRealm.setDefaultRealmSchemaVersion(8, withMigrationBlock: {migration, oldSchemaVersion in
      // do nothing here, auto migration
    })
    println(REALM.path)
  }

  static func getProfile(rowId: UInt) -> Profile {
    let profiles = Profile.allObjects()
    if (profiles.count <= rowId) {
      for _ in profiles.count...rowId {
        REALM.transactionWithBlock({ () -> Void in
          self.REALM.addObject(Profile())
        })
      }
    }
    return profiles[rowId] as! Profile
  }

  static func getMe() -> Profile {
    return getProfile(0)
  }

  static func getDraftMe() -> Profile {
    return getProfile(1)
  }
}


class Profile: RLMObject {
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
}
