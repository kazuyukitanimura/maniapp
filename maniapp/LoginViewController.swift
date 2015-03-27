//
//  LoginViewController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/26/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIGestureRecognizerDelegate {
  let colorTop = UIColor(red: 255.0/255.0, green: 230.0/255.0, blue: 0.0/255.0, alpha: 1.0).CGColor
  let colorBottom = UIColor(red: 255.0/255.0, green: 102.0/255.0, blue: 0.0/255.0, alpha: 1.0).CGColor
  let backgroundGradient = CAGradientLayer()

  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundGradient.colors = [colorTop, colorBottom]
    backgroundGradient.locations = [0.0, 1.0]
    backgroundGradient.frame = view.frame
    view.layer.insertSublayer(backgroundGradient, atIndex: 0)
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTapGesture:"))
  }

  func handleTapGesture(recognizer: UITapGestureRecognizer) {
    view.removeFromSuperview()
  }
}