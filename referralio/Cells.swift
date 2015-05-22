//
//  Cells.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 3/30/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

let profileSize:CGFloat = 56
let bigPad = 24
let pad = 16
let padThreeQuarter = 12
let padHalf = 8
let padQuarter = 4
var cells:[ConstrainedViews] = [
  // 0
  ConstrainedViews(views: [
    "title": [
      "text": "Your Name",
      "font": AppFonts.titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "Tap to pdate your title and affiliation",
      "font": AppFonts.subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "photo": [
      "image": "defaultProfile2.png",
      "frame": NSValue(CGRect: CGRectMake(0, 0, profileSize, profileSize)),
      "toCircle": true,
      "contentMode": UIViewContentMode.ScaleAspectFill.rawValue,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-\(padThreeQuarter)-[photo(\(profileSize))]-\(pad)-[title]-\(pad)-|",
      "H:|-\(padThreeQuarter)-[photo(\(profileSize))]-\(pad)-[subTitle]-\(pad)-|",
      "H:|-\(pad)-[preview]-\(pad)-|",
      "V:|-\(pad)-[title]-\(padHalf)-[subTitle]-(>=\(pad))-|",
      "V:|-\(pad)-[photo(\(profileSize))]-\(padHalf)-[preview]-(>=\(padHalf))-|",
    ]),
  // 1
  ConstrainedViews(views: [
    "title": [
      "text": "Referral Center",
      "font": AppFonts.titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "Check your referral status or Update your interview status",
      "font": AppFonts.subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "notifications": [
      "text": "0 new notifications",
      "font": AppFonts.subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-\(padThreeQuarter)-[title]-\(pad)-|",
      "H:|-\(padThreeQuarter)-[subTitle]-\(pad)-|",
      "H:|-\(padThreeQuarter)-[notifications]-\(pad)-|",
      "H:|-\(pad)-[preview]-\(pad)-|",
      "V:|-\(pad)-[title]-\(padHalf)-[subTitle]-\(padHalf)-[notifications]-\(padHalf)-[preview]-(>=\(padHalf))-|",
    ]),
  // 2
  ConstrainedViews(views: [
    "title": [
      "text": "Friends",
      "font": AppFonts.titleFont,
      "textColor": AppColors.Orange,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-\(padThreeQuarter)-[title]-\(pad)-|",
      "H:|-\(pad)-[preview]-\(pad)-|",
      "V:|-\(pad)-[title]-\(padHalf)-[preview]-(>=\(padHalf))-|",
    ]),
  // 3
  ConstrainedViews(views: [
    "title": [
      "text": "News Feed 1",
      "font": AppFonts.titleFont,
      "textColor": AppColors.Orange,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-\(padThreeQuarter)-[title]-\(pad)-|",
      "H:|-\(pad)-[preview]-\(pad)-|",
      "V:|-\(pad)-[title]-\(padHalf)-[preview]-(>=\(padHalf))-|",
    ]),
  // 4
  ConstrainedViews(views: [
    "title": [
      "text": "News Feed 2",
      "font": AppFonts.titleFont,
      "textColor": AppColors.Orange,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-\(padThreeQuarter)-[title]-\(pad)-|",
      "H:|-\(pad)-[preview]-\(pad)-|",
      "V:|-\(pad)-[title]-\(padHalf)-[preview]-(>=\(padHalf))-|",
    ]),
]