//
//  Cells.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 3/30/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

let profileSize:CGFloat = 56
let smallProfileSize = profileSize * 0.6

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
      "H:|-\(AppPaddings.threeQuarter)-[photo(\(profileSize))]-\(AppPaddings.one)-[title]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.threeQuarter)-[photo(\(profileSize))]-\(AppPaddings.one)-[subTitle]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.one)-[preview]-\(AppPaddings.one)-|",
      "V:|-\(AppPaddings.one)-[title]-\(AppPaddings.half)-[subTitle]-(>=\(AppPaddings.one))-|",
      "V:|-\(AppPaddings.one)-[photo(\(profileSize))]-\(AppPaddings.half)-[preview]-(>=\(AppPaddings.half))-|",
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
      "H:|-\(AppPaddings.threeQuarter)-[title]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.threeQuarter)-[subTitle]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.threeQuarter)-[notifications]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.one)-[preview]-\(AppPaddings.one)-|",
      "V:|-\(AppPaddings.one)-[title]-\(AppPaddings.half)-[subTitle]-\(AppPaddings.half)-[notifications]-\(AppPaddings.half)-[preview]-(>=\(AppPaddings.half))-|",
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
      "H:|-\(AppPaddings.threeQuarter)-[title]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.one)-[preview]-\(AppPaddings.one)-|",
      "V:|-\(AppPaddings.one)-[title]-\(AppPaddings.half)-[preview]-(>=\(AppPaddings.half))-|",
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
      "H:|-\(AppPaddings.threeQuarter)-[title]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.one)-[preview]-\(AppPaddings.one)-|",
      "V:|-\(AppPaddings.one)-[title]-\(AppPaddings.half)-[preview]-(>=\(AppPaddings.half))-|",
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
      "H:|-\(AppPaddings.threeQuarter)-[title]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.one)-[preview]-\(AppPaddings.one)-|",
      "V:|-\(AppPaddings.one)-[title]-\(AppPaddings.half)-[preview]-(>=\(AppPaddings.half))-|",
    ]),
]