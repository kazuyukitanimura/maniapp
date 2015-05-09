//
//  Extensions.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/25/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

/*
extension NSObject {
  func setValuesForKeysWithAnyDictionary(keyedValues: [NSObject : Any]) {
    for (id, value) in keyedValues {
      self[id] = value
    }
  }
}*/

extension String {
  var length: Int {
    get {
      return count(self)
    }
  }

  func trim() -> String {
    return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
  }

  func replace(pattern: String, with: String) -> String? {
    let regexp = NSRegularExpression(pattern: pattern, options: nil, error: nil)
    return regexp?.stringByReplacingMatchesInString(self, options: nil, range: NSMakeRange(0, self.length), withTemplate: with)
  }

  func toFloat() -> Float {
    return (self as NSString).floatValue
  }
}

extension UIView {
  func removeAllSubviews() {
    subviews.map { $0.removeFromSuperview() }
  }
}

extension UIImageView {
  var toCircle:Bool {
    get {
      return layer.cornerRadius == frame.size.width / 2 && clipsToBounds
    }
    set (value) {
      if (value) {
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
      } else {
        layer.cornerRadius = 0
        clipsToBounds = false
      }
    }
  }
}

extension UITextField {
  func boldFont() {
    font = UIFont.boldSystemFontOfSize(font.pointSize)
  }

  func highlight() {
    boldFont()
    textColor = AppColors.Orange
  }
}

extension Array {
  // http://stackoverflow.com/questions/24102024/how-to-check-if-an-element-is-in-an-array
  func contains<T where T : Equatable>(obj: T) -> Bool {
    return self.filter({ $0 as? T == obj }).count > 0
  }

  func contains<T where T : Equatable>(obj: AnyObject?, compare: (lhs: T?, rhs:AnyObject?) -> Bool) -> Bool {
    return self.filter({ compare(lhs: ($0 as? T), rhs: obj) }).count > 0
  }
}

extension Dictionary {
  func hasKey(_key: Key) -> Bool {
    return indexForKey(_key) != nil
  }
}

extension UIImage {
  func resizeTo(length: CGFloat) -> UIImage {
    let minLength = min(size.width, size.height)
    let raito = minLength / min(minLength, length)
    let newSize = CGSizeMake(size.width / raito, size.height / raito)
    UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
    drawInRect(CGRect(origin: CGPointZero, size: newSize))
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return scaledImage
  }
}