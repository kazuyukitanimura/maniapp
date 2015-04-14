//
//  AppButtons.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/12/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class AppButton: UIButton {
  override init() {
    super.init(frame: CGRectMake(0,0,0,0))
    layer.masksToBounds = true
    layer.cornerRadius = 4.0
    layer.borderWidth = 1
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

class SaveButton: AppButton {
  override init() {
    super.init()
    backgroundColor = AppColors.Orange
    setTitle("Save", forState: .Normal)
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    println("here")
  }
}

class DraftButton: AppButton {
  override init() {
    super.init()
    setTitle("Save as draft", forState: .Normal)
    setTitleColor(AppColors.Orange, forState: .Normal)
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    println("here")
  }
}

class CancelButton: AppButton {
  override init() {
    super.init()
    setTitle("Cancel", forState: .Normal)
    setTitleColor(AppColors.DarkGray, forState: .Normal)
    layer.borderColor = AppColors.DarkGray.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    println("here")
  }
}