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
  let headerView = UIView()

  override func viewDidLoad() {
    super.viewDidLoad()

    // for iPad
    modalPresentationStyle = .FormSheet

    // set the transition style
    modalTransitionStyle = .CoverVertical

    // innerView
    headerView.backgroundColor = AppColors.DarkOrange
    headerView.tintColor = AppColors.White
    innerView.backgroundColor = AppColors.White

    let constrainedViews = ConstrainedViews(views: [
      "headerView": headerView,
      "innerView": innerView,
      ], formats:[
        "H:|-0-[headerView]-0-|",
        "H:|-0-[innerView]-0-|",
        "V:|-0-[headerView(64)]-0-[innerView]-0-|"
      ])
    view.addConstrainedViews(constrainedViews)
  }

  func dismiss() {
    dismissViewControllerAnimated(true, completion: nil)
  }
}