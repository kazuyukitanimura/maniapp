//
//  ModalViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 7/9/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
  let innerView = UIView()

  override func viewDidLoad() {
    super.viewDidLoad()

    // for iPad
    modalPresentationStyle = .FormSheet

    // set the transition style
    modalTransitionStyle = .CoverVertical

    // Build a modal background
    view.backgroundColor = AppColors.BlackAlpha

    // innerView
    innerView.backgroundColor = AppColors.White

    let constrainedViews = ConstrainedViews(views: [
      "innerView": innerView
      ], formats:[
        "H:|-\(AppPaddings.double)-[innerView]-\(AppPaddings.double)-|",
        "V:|-\(AppPaddings.double)-[innerView]-\(AppPaddings.double)-|"
      ])
    view.addConstrainedViews(constrainedViews)
  }

  func dismiss() {
    dismissViewControllerAnimated(true, completion: nil)
  }
}