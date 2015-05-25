//
//  DoneBar.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 5/10/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class DoneBar: UIToolbar {
  private var target: UITextFieldDelegate!
  private var textField: UITextField!

  init(target: UITextFieldDelegate, textField: UITextField) {
    super.init(frame: CGRectMake(0, 0, 1, 44))
    self.target = target
    self.textField = textField
    barTintColor = AppColors.White
    alpha = 0.7
    let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    let title = (textField.returnKeyType == .Next) ? "Next" : "Done"
    let doneButton = UIBarButtonItem(title: title, style: .Done, target: self, action: "doneButtonPressed:")
    items = [flexSpace, doneButton]
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func doneButtonPressed(sender: UIBarButtonItem) {
    target.textFieldShouldReturn?(textField)
  }
}

