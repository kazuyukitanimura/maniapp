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

class Profile: RLMObject {
  dynamic var firstName = ""
  dynamic var lastName = ""
}
