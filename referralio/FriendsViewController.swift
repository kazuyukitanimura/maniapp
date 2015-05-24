//
//  FriendsViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 5/22/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class Friend: ConstrainedViews {
  init(profile: Profile) {
    super.init(views: [
      "title": [
        "text": "\(profile.firstName) \(profile.lastName)",
        "font": AppFonts.smallTitleFont,
        "textColor": AppColors.Orange,
      ],
      "subTitle": [
        "text": (profile.currentTitle.isEmpty || profile.currentAffiliation.isEmpty) ? "\(profile.currentTitle)\(profile.currentAffiliation)" : "\(profile.currentTitle) at \(profile.currentAffiliation)",
        "font": AppFonts.subTitleFont,
        "textColor": AppColors.DarkGray,
      ],
      "photo": [
        "image": "defaultProfile2.png",
        "frame": NSValue(CGRect: CGRectMake(0, 0, smallProfileSize, smallProfileSize)),
        "toCircle": true,
        "contentMode": UIViewContentMode.ScaleAspectFill.rawValue,
      ],
    ], formats: [
      "H:|-\(AppPaddings.half)-[photo(\(smallProfileSize))]-\(AppPaddings.one)-[title]-|",
      "H:|-\(AppPaddings.half)-[photo(\(smallProfileSize))]-\(AppPaddings.one)-[subTitle]-|",
      "V:|-\(AppPaddings.quarter + AppPaddings.halfQuarter)-[title]-\(AppPaddings.halfQuarter)-[subTitle]-(>=\(AppPaddings.quarter))-|",
      "V:|-\(AppPaddings.half)-[photo(\(smallProfileSize))]-(>=\(AppPaddings.half))-|",
    ])
  }
}

class FriendsViewController: PreviewViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // import contacts

    var views = [String: Friend]()
    var formats = [String]()
    var vFormats = [String]()
    for i:UInt in 2..<7 {
      let key = "friend\(i)"
      views[key] = Friend(profile: Models.getProfile(i))
      formats.append("H:|-0-[\(key)]-0-|")
      vFormats.append("[\(key)]")
    }
    formats.append("V:|-\(AppPaddings.half)-" + "-".join(vFormats) + "-\(AppPaddings.half)-|")
    view.addConstrainedViews(ConstrainedViews(views: views, formats: formats))
  }
}
