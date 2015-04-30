//
//  Animations.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/2/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit
import AudioToolbox

struct Animations {
  static func bloat(target: UIView) {
    var animation = CABasicAnimation(keyPath: "transform.scale")
    animation.toValue = NSNumber(float: 0.95)
    animation.duration = 0.1
    animation.repeatCount = 2.0
    animation.autoreverses = true
    target.layer.addAnimation(animation, forKey: nil)
  }
}


func Vibrrate() {
  NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
  })
}
