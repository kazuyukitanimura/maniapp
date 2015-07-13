//
//  OfferViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 7/9/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class OfferViewController: ModalViewController {
  let cancelButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
  let sendButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton

  override func viewDidLoad() {
    super.viewDidLoad()

    cancelButton.setTitle("Cancel", forState: .Normal)
    cancelButton.titleLabel!.font = UIFont.systemFontOfSize(24.0)
    cancelButton.frame = CGRectMake(0,0,200,50)
    cancelButton.setTitleColor(AppColors.White, forState: .Normal)
    cancelButton.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)

    sendButton.setTitle("Send", forState: .Normal)
    sendButton.titleLabel!.font = UIFont.systemFontOfSize(24.0)
    sendButton.frame = CGRectMake(0,0,200,50)
    sendButton.setTitleColor(AppColors.White, forState: .Normal)
    sendButton.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)

    let headerViews = ConstrainedViews(views: [
      "cancel": cancelButton,
      "send": sendButton,
      ], formats: [
        "H:|-[cancel]-(>=\(AppPaddings.one))-[send]-|",
        "V:|-[cancel]-|",
        "V:|-[send]-|",
      ])
    headerView.addConstrainedViews(headerViews)

    let innerViews = ConstrainedViews(views: [
      "from": [
        "image": "defaultProfile2.png",
        "frame": NSValue(CGRect: CGRectMake(0, 0, profileSize, profileSize)),
        "toCircle": true,
        "contentMode": UIViewContentMode.ScaleAspectFill.rawValue,
      ],
      "message": [
        "font": AppFonts.normalFont,
        "textColor": AppColors.Black,
        "template": ["Hi {name},", "### persona message ###", "### the job description ###"],
      ],
      ], formats:[
        "H:|-\(AppPaddings.threeQuarter)-[from(\(profileSize))]-(>=\(AppPaddings.one))-|",
        "H:|-\(AppPaddings.threeQuarter)-[message]-\(AppPaddings.one)-|",
        "V:|-\(AppPaddings.threeQuarter)-[from(\(profileSize))]-\(AppPaddings.oneHalf)-[message]-(>=\(AppPaddings.one))-|",
      ])
    innerView.addConstrainedViews(innerViews)
  }
}