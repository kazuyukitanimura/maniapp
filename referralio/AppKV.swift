//
//  AppKV.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 4/12/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import Foundation


func kvStore(k: String, v: AnyObject) {
  NSUserDefaults.standardUserDefaults().setObject(v, forKey: k)
  NSUserDefaults.standardUserDefaults().synchronize()
}

func kvLoad(k: String) -> AnyObject? {
  return NSUserDefaults.standardUserDefaults().objectForKey(k)
}