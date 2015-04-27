//
//  Models.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/18/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import Realm

// Get the default Realm
let REALM = RLMRealm.defaultRealm()

func SetupRealm() {
  RLMRealm.setDefaultRealmSchemaVersion(5, withMigrationBlock: {migration, oldSchemaVersion in
    // do nothing here, auto migration
  })
  println(REALM.path)
}

func GetProfile(rowId: UInt) -> Profile {
  let profiles = Profile.allObjects()
  if (profiles.count <= rowId) {
    for _ in profiles.count...rowId {
      REALM.transactionWithBlock({ () -> Void in
        REALM.addObject(Profile())
      })
    }
  }
  return profiles[rowId] as! Profile
}

func GetMe() -> Profile {
  return GetProfile(0)
}

func GetDraftMe() -> Profile {
  return GetProfile(1)
}

class Profile: RLMObject {
  dynamic var firstName = ""
  dynamic var lastName = ""
  dynamic var currentAffiliation = ""
  dynamic var currentTitle = ""
  dynamic var currentLocation = ""
  dynamic var willingToRelocate = ""
  dynamic var distance = 0 // myself is 0, direct friend is 1
}
