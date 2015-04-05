//
//  Cells.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/30/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

extension UIImageView {
  var toCircle:Bool {
    get {
      return layer.cornerRadius == frame.size.width / 2 && clipsToBounds
    }
    set (value) {
      if (value) {
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
      } else {
        layer.cornerRadius = 0
        clipsToBounds = false
      }
    }
  }
}

let titleFont = UIFont.systemFontOfSize(17.0)
let subTitleFont = UIFont.systemFontOfSize(12.0)
let cells:[ConstrainedViews] = [
  // 0
  ConstrainedViews(views: [
    "title": [
      "text": "Kazuyuki Tanimura",
      "font": titleFont,
      "textColor": AppColors.Orange,
      ],
    "subTitle" : [
      "text": "Member of Technical Staff at BloomReach, Inc.",
      "font": subTitleFont,
      "textColor": AppColors.DarkGray,
      ],
    "photo": [
      "image": "profile-rabbit-toy.png",
      "frame": NSValue(CGRect: CGRectMake(0, 0, 56, 56)),
      "toCircle": true,
      ],
    "preview" : [
      "text": "Tap to update your target compensation",
      "font": subTitleFont,
      ],
    ], formats:[
      "H:|-8-[photo(56)]-8-[title]-8-|",
      "H:|-8-[photo(56)]-8-[subTitle]-8-|",
      "H:|-8-[preview]-8-|",
      "V:|-8-[title]-2-[subTitle]-(>=8)-|",
      "V:|-8-[photo(56)]-8-[preview]-(>=8)-|"]),
  // 1
  ConstrainedViews(views: [
    "title": [
      "text": "Referral Center",
      "font": titleFont,
      "textColor": AppColors.Orange,
      ],
    "subTitle" : [
      "text": "Check your referral status or Update your interview status",
      "font": subTitleFont,
      "textColor": AppColors.DarkGray,
      ],
    ], formats:[
    "H:|-8-[title]-8-|",
    "H:|-8-[subTitle]-8-|",
    "V:|-8-[title]-2-[subTitle]-8-|"]),
  // 2
  ConstrainedViews(views: [
    "title": [
      "text": "Notifications",
      "font": titleFont,
      "textColor": AppColors.Orange,
    ],
    "subTitle" : [
      "text": "0 notifications",
      "font": subTitleFont,
      "textColor": AppColors.DarkGray,
    ],
  ], formats:[
    "H:|-8-[title]-8-|",
    "H:|-8-[subTitle]-8-|",
    "V:|-8-[title]-2-[subTitle]-8-|"]),
  // 3
  ConstrainedViews(views: ["news": [
    "text": "News Feed",
    "font": titleFont,
    "textColor": AppColors.Orange,
  ]], formats:[
    "H:|-8-[news]-8-|",
    "V:|-8-[news]-608-|"]),
]