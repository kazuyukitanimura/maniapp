//
//  MultipleChoiceViewController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/30/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class MultipleChoiceViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  let pickerView = UIPickerView()
  var choices: [String]!
  weak var textField: UITextField!

  init (choices: [String], textField: UITextField) {
    super.init(nibName: nil, bundle: nil)
    self.choices = choices
    self.textField = textField
    pickerView.dataSource = self
    pickerView.delegate = self
    textField.inputView = pickerView
    textField.addSubview(view)
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
    textField.text = choices[row]
    view.endEditing(true)
  }

/*  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
    let pickerLabel = UILabel()
    let titleData = choices[row]
    let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
    pickerLabel.attributedText = myTitle
    return pickerLabel
  }*/
}