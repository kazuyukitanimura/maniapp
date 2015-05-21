//
//  MultipleChoiceView.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 4/30/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class MultipleChoiceView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
  var choices: [String]!
  weak var textField: UITextField!

  init (choices: [String], textField: UITextField) {
    super.init(frame: CGRectMake(0, 0, 0, 40))
    self.choices = choices
    self.textField = textField
    dataSource = self
    delegate = self
    textField.inputView = self
    backgroundColor = AppColors.Orange.colorWithAlphaComponent(0.9)
    selectRow(find(choices, textField.text) ?? 0, inComponent: 0, animated: false)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return choices.count
  }

  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    return choices[row]
  }

  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    textField.highlight() // TODO unhighlight when editted back
    textField.text = choices[row]
  }

  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
    let pickerLabel = UILabel()
    pickerLabel.textColor = AppColors.White
    pickerLabel.text = choices[row]
    pickerLabel.font = AppFonts.pickerFont
    pickerLabel.textAlignment = NSTextAlignment.Center
    return pickerLabel
  }
}