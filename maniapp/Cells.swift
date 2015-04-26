//
//  Cells.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/30/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

let titleFont = UIFont.systemFontOfSize(17.0)
let subTitleFont = UIFont.systemFontOfSize(12.0)
let profileSize:CGFloat = 56
let pad = 16
let padHalf = 8
var cells:[ConstrainedViews] = [
  // 0
  ConstrainedViews(views: [
    "title": [
      "text": "Your Name",
      "font": titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "Tap to pdate your title and affiliation",
      "font": subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "photo": [
      "image": "profile-rabbit-toy.png",
      "frame": NSValue(CGRect: CGRectMake(0, 0, profileSize, profileSize)),
      "toCircle": true,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-\(pad)-[photo(\(profileSize))]-\(pad)-[title]-\(pad)-|",
      "H:|-\(pad)-[photo(\(profileSize))]-\(pad)-[subTitle]-\(pad)-|",
      "H:|-\(pad)-[preview]-\(pad)-|",
      "V:|-\(pad)-[title]-\(padHalf)-[subTitle]-(>=\(pad))-|",
      "V:|-\(pad)-[photo(\(profileSize))]-\(padHalf)-[preview]-(>=\(padHalf))-|",
    ]),
  // 1
  ConstrainedViews(views: [
    "title": [
      "text": "Referral Center",
      "font": titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "Check your referral status or Update your interview status",
      "font": subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-8-[title]-8-|",
      "H:|-8-[subTitle]-8-|",
      "H:|-8-[preview]-8-|",
      "V:|-8-[title]-2-[subTitle]-4-[preview]-(>=4)-|",
    ]),
  // 2
  ConstrainedViews(views: [
    "title": [
      "text": "Notifications",
      "font": titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "0 new notifications",
      "font": subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-8-[title]-8-|",
      "H:|-8-[subTitle]-8-|",
      "H:|-8-[preview]-8-|",
      "V:|-8-[title]-2-[subTitle]-4-[preview]-(>=4)-|",
    ]),
  // 3
  ConstrainedViews(views: [
    "title": [
      "text": "News Feed 1",
      "font": titleFont,
      "textColor": AppColors.Orange,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-8-[title]-8-|",
      "H:|-8-[preview]-8-|",
      "V:|-8-[title]-4-[preview]-(>=4)-|",
    ]),
  // 4
  ConstrainedViews(views: [
    "title": [
      "text": "News Feed 2",
      "font": titleFont,
      "textColor": AppColors.Orange,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-8-[title]-8-|",
      "H:|-8-[preview]-8-|",
      "V:|-8-[title]-4-[preview]-(>=4)-|",
    ]),
]