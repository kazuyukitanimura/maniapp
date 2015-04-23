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
  RLMRealm.setDefaultRealmSchemaVersion(2, withMigrationBlock: {migration, oldSchemaVersion in
    // do nothing here, auto migration
  })
  println(REALM.path)
}

class Profile: RLMObject {
  dynamic var firstName = ""
  dynamic var lastName = ""
  dynamic var currentAffiliation = ""
  dynamic var distance = 0 // myself is 0, direct friend is 1
  dynamic var published = false // published == false means draft stage
}
