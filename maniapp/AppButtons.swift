//
//  AppButtons.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/12/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

protocol AppButtonDelegate {
  func saved()
  func drafted()
  func canceled()
}

class AppButton: UIButton {
  var delegate: AppButtonDelegate?

  init(delegate: AppButtonDelegate?) {
    super.init(frame: CGRectMake(0,0,0,0))
    self.delegate = delegate
    layer.masksToBounds = true
    layer.cornerRadius = 4.0
    layer.borderWidth = 1
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

class SaveButton: AppButton {
  override init(delegate: AppButtonDelegate?) {
    super.init(delegate: delegate)
    backgroundColor = AppColors.Orange
    setTitle("Save", forState: .Normal)
    setTitleColor(AppColors.White, forState: .Normal)
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    delegate?.saved()
  }
}

class DraftButton: AppButton {
  override init(delegate: AppButtonDelegate?) {
    super.init(delegate: delegate)
    setTitle("Save as draft", forState: .Normal)
    setTitleColor(AppColors.Orange, forState: .Normal)
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    delegate?.drafted()
  }
}

class CancelButton: AppButton {
  override init(delegate: AppButtonDelegate?) {
    super.init(delegate: delegate)
    setTitle("Cancel", forState: .Normal)
    setTitleColor(AppColors.DarkGray, forState: .Normal)
    layer.borderColor = AppColors.DarkGray.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    delegate?.canceled()
  }
}


class UpdatePhotoButton: AppButton {
  let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)

  init() {
    super.init(delegate: nil)
    setTitle("Update photo", forState: .Normal)
    setTitleColor(AppColors.Orange, forState: .Normal)
    titleLabel!.font = UIFont.boldSystemFontOfSize(13.0)
    layer.borderColor = AppColors.Orange.CGColor
    addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
    activityView.frame = CGRect(x: 8, y: 4, width: 25, height: 25)
    activityView.startAnimating()
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func onClickButton(sender: UIButton) {
    addSubview(activityView)
    let photoController = PhotoController()
    addSubview(photoController.view)
    photoController.presentViewController(activityView.removeFromSuperview)
  }
}
