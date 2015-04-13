//
//  AppButtons.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/12/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class SaveButton: UIButton {
  override init() {
    super.init(frame: CGRectMake(0,0,0,0))
    backgroundColor = AppColors.Orange
    layer.masksToBounds = true
    setTitle("Save", forState: .Normal)
    layer.cornerRadius = 16.0
    layer.borderColor = AppColors.Orange.CGColor
    layer.borderWidth = 1
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

class DraftButton: UIButton {
  override init() {
    super.init(frame: CGRectMake(0,0,0,0))
    layer.masksToBounds = true
    setTitle("Save as draft", forState: .Normal)
    layer.cornerRadius = 16.0
    setTitleColor(AppColors.Orange, forState: .Normal)
    layer.borderColor = AppColors.Orange.CGColor
    layer.borderWidth = 1
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

class CancelButton: UIButton {
  override init() {
    super.init(frame: CGRectMake(0,0,0,0))
    layer.masksToBounds = true
    setTitle("Cancel", forState: .Normal)
    layer.cornerRadius = 16.0
    setTitleColor(AppColors.DarkGray, forState: .Normal)
    layer.borderColor = AppColors.DarkGray.CGColor
    layer.borderWidth = 1
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}