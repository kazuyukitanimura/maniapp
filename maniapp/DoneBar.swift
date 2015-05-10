//
//  DoneBar.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 5/10/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class DoneBar: UIToolbar {
  init(target: UIView) {
    super.init(frame: CGRectMake(0, 0, 1, 32))
    barTintColor = AppColors.White
    alpha = 0.7
    let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: target, action: "resignFirstResponder")
    items = [flexSpace, doneButton]
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

