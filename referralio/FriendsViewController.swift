//
//  FriendsViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 5/22/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class Friend: ConstrainedViews {
  init() {
    let firstName = "Friend"
    let lastName = "1"
    let currentTitle = "boss"
    let currentAffiliation = "somewhere"

    super.init(views: [
      "title": [
        "text": "\(firstName) \(lastName)",
        "font": AppFonts.smallTitleFont,
        "textColor": AppColors.Orange,
      ],
      "subTitle": [
        "text": "\(currentTitle) at \(currentAffiliation)",
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

    let friendRows = ConstrainedViews(views: [
      "friend1": Friend(),
      "friend2": Friend(),
      "friend3": Friend(),
      "friend4": Friend(),
      "friend5": Friend(),
    ], formats: [
      "H:|-0-[friend1]-0-|",
      "H:|-0-[friend2]-0-|",
      "H:|-0-[friend3]-0-|",
      "H:|-0-[friend4]-0-|",
      "H:|-0-[friend5]-0-|",
      "V:|-\(AppPaddings.half)-[friend1]-[friend2]-[friend3]-[friend4]-[friend5]-\(AppPaddings.half)-|",
    ])
    view.addConstrainedViews(friendRows)
  }
}
