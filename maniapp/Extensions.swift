//
//  Extensions.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/25/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

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

extension Array {
  // http://stackoverflow.com/questions/24102024/how-to-check-if-an-element-is-in-an-array
  func contains<T where T : Equatable>(obj: T) -> Bool {
    return self.filter({ $0 as? T == obj }).count > 0
  }

  func contains<T where T : Equatable>(obj: AnyObject?, compare: (lhs: T?, rhs:AnyObject?) -> Bool) -> Bool {
    return self.filter({ compare(lhs: ($0 as? T), rhs: obj) }).count > 0
  }
}