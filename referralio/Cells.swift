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
      "text": "Referral Status",
      "font": AppFonts.titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "0 new notifications",
      "font": AppFonts.subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-\(AppPaddings.threeQuarter)-[title]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.threeQuarter)-[subTitle]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.one)-[preview]-\(AppPaddings.one)-|",
      "V:|-\(AppPaddings.one)-[title]-\(AppPaddings.half)-[subTitle]-\(AppPaddings.half)-[preview]-(>=\(AppPaddings.half))-|",
    ]),
  // 2
  ConstrainedViews(views: [
    "title": [
      "text": "Send Referrals of Me or Friends",
      "font": AppFonts.titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "0 in-coming referrals to send out",
      "font": AppFonts.subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-\(AppPaddings.threeQuarter)-[title]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.threeQuarter)-[subTitle]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.one)-[preview]-\(AppPaddings.one)-|",
      "V:|-\(AppPaddings.one)-[title]-\(AppPaddings.half)-[subTitle]-\(AppPaddings.half)-[preview]-(>=\(AppPaddings.half))-|",
    ]),
  // 3
  ConstrainedViews(views: [
    "title": [
      "text": "I Know a Job to Offer",
      "font": AppFonts.titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "0 in-coming referrals to reply",
      "font": AppFonts.subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-\(AppPaddings.threeQuarter)-[title]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.threeQuarter)-[subTitle]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.one)-[preview]-\(AppPaddings.one)-|",
      "V:|-\(AppPaddings.one)-[title]-\(AppPaddings.half)-[subTitle]-\(AppPaddings.half)-[preview]-(>=\(AppPaddings.half))-|",
    ]),
  // 4
  ConstrainedViews(views: [
    "title": [
      "text": "Pay \"Thank You\" Tips",
      "font": AppFonts.titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle": [
      "text": "0 referrals to tip",
      "font": AppFonts.subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
    "preview": UIView(),
    ], formats: [
      "H:|-\(AppPaddings.threeQuarter)-[title]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.threeQuarter)-[subTitle]-\(AppPaddings.one)-|",
      "H:|-\(AppPaddings.one)-[preview]-\(AppPaddings.one)-|",
      "V:|-\(AppPaddings.one)-[title]-\(AppPaddings.half)-[subTitle]-\(AppPaddings.half)-[preview]-(>=\(AppPaddings.half))-|",
    ]),
  // 5
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
  // 6
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
  // 7
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