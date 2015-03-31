//
//  Cells.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/30/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

struct ContentViews {
  var views: [String: UIView]! // key: view
  var formats: [String]! // NSLayoutConstraint.constraintsWithVisualFormat
}

let cells:[ContentViews] = [
  ContentViews(views: ["profile": UILabel()], formats:["H:|-5-[profile]-5-|", "V:|-5-[profile]-5-|"]),
  ContentViews(views: ["referral": UILabel()], formats:["H:|-5-[referral]-5-|", "V:|-5-[referral]-5-|"]),
  ContentViews(views: ["notification": UILabel()], formats:["H:|-5-[notification]-5-|", "V:|-5-[notification]-5-|"]),
  ContentViews(views: ["news": UILabel()], formats:["H:|-5-[news]-5-|", "V:|-5-[news]-5-|"]),
]