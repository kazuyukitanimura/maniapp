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

extension UIView {
  func addConstrainedViews(constrainedViews: ConstrainedViews) {
    var views = [String: UIView]()
    for (id, viewProps) in constrainedViews.views {
      var subView: UIView
      if let viewSelf = viewProps as? UIView {
        subView = viewSelf
      } else {
        if let textProp = viewProps["text"] as? String {
          subView = UILabel()
          (subView as UILabel).text = textProp
          (subView as UILabel).numberOfLines = 0
        } else if let imageProp = viewProps["image"] as? UIImage {
          subView = UIImageView()
          (subView as UIImageView).image = imageProp
        } else {
          subView = UIView()
        }
        subView.setValuesForKeysWithDictionary(viewProps as Dictionary)
      }
      addSubview(subView)
      subView.setTranslatesAutoresizingMaskIntoConstraints(false)
      views[id] = subView
    }
    for format in constrainedViews.formats {
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: .AlignAllLeft, metrics: nil, views: views))
    }
  }
}

struct ConstrainedViews {
  var views: [String: AnyObject]! // key: {property: value}
  var formats: [String]! // NSLayoutConstraint.constraintsWithVisualFormat
}

let titleFont = UIFont.boldSystemFontOfSize(14.0)
let cells:[ConstrainedViews] = [
  // 0
  ConstrainedViews(views: [
    "title": [
      "text": "My Profile",
      "font": titleFont
      ]/*,
    "photo": [
      "image": UIImage(named: "profile-rabbit-toy.png"),
      "frame": CGRectMake(0, 0, 100, 100),
      "toCircle": true
      ]*/
    ], formats:[
      "H:|-8-[title]-8-|",
      "V:|-8-[title]-8-|"]),
      //"H:|-8-[photo]-8-[title]-8-|",
      //"V:|-8-[photo]-8-|"]),
  // 1
  ConstrainedViews(views: ["referral": [
    "text": "Referral Center",
    "font": titleFont
  ]], formats:[
    "H:|-8-[referral]-8-|",
    "V:|-8-[referral]-8-|"]),
  // 2
  ConstrainedViews(views: ["notification": [
    "text": "Notifications",
    "font": titleFont
  ]], formats:[
    "H:|-8-[notification]-8-|",
    "V:|-8-[notification]-8-|"]),
  // 3
  ConstrainedViews(views: ["news": [
    "text": "News Feed",
    "font": titleFont
  ]], formats:[
    "H:|-8-[news]-8-|",
    "V:|-8-[news]-8-|"]),
]