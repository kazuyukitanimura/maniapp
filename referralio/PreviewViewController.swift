//
//  PreviewViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 5/22/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    parentViewController?.addChildViewController(self)
    didMoveToParentViewController(parentViewController)
    view.backgroundColor = AppColors.Clear
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapHandler:"))
  }

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    removeFromParentViewController()
  }

  func tapHandler(recognizer: UITapGestureRecognizer) {
    // empty function to swallow the default behavior, which is showing the navigation bar
  }
}