//
//  OfferViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 7/9/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class OfferViewController: ModalViewController {
  let dismissButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton

  override func viewDidLoad() {
    super.viewDidLoad()

    // the done button
    dismissButton.setTitle("Send", forState: .Normal)
    dismissButton.titleLabel!.font = UIFont(name: "Helvetica", size: 24)
    dismissButton.titleLabel!.textAlignment = .Left
    dismissButton.frame = CGRectMake(0,0,200,50)
    dismissButton.setTitleColor(AppColors.Orange, forState: .Normal)
    dismissButton.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)

    let constrainedViews = ConstrainedViews(views: [
      "from": [
        "image": "defaultProfile2.png",
        "frame": NSValue(CGRect: CGRectMake(0, 0, profileSize, profileSize)),
        "toCircle": true,
        "contentMode": UIViewContentMode.ScaleAspectFill.rawValue,
      ],
      "message": [
        "placeholder": "the job description",
        "font": AppFonts.normalFont,
        "textColor": AppColors.Black,
      ],
      "send": dismissButton,
      ], formats:[
        "H:|-[from(\(profileSize))]-[send]-|",
        "H:|-[message]-|",
        "V:|-[from(\(profileSize))]-\(AppPaddings.one)-[message]-|",
        "V:|-[send(\(profileSize))]-\(AppPaddings.one)-[message]-|",
      ])
    innerView.addConstrainedViews(constrainedViews)
  }
}