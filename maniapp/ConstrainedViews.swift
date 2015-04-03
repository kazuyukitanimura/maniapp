//
//  ConstrainedViews.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/2/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

extension UIView {
  func addConstrainedViews(constrainedViews: ConstrainedViews) {
    var views = [String: UIView]()
    for (id, viewObject) in constrainedViews.views {
      var subView: UIView
      if let viewSelf = viewObject as? UIView {
        subView = viewSelf
      } else {
        var viewProps = viewObject as Dictionary<String, AnyObject>
        if let textProp = viewProps["text"] as? String {
          subView = UILabel()
          (subView as UILabel).numberOfLines = 0
        } else if let imageName = viewProps["image"] as? String {
          subView = UIImageView()
          viewProps["image"] = UIImage(named: imageName)
          if let frameRect = viewProps["frame"] as? NSValue {
            (subView as UIImageView).frame = frameRect.CGRectValue()
            viewProps.removeValueForKey("frame")
          }
        } else {
          subView = UIView()
        }
        subView.setValuesForKeysWithDictionary(viewProps as Dictionary)
      }
      addSubview(subView)
      subView.setTranslatesAutoresizingMaskIntoConstraints(false)
      views[id] = subView
    }
    for format in constrainedViews.formats {
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: nil, metrics: nil, views: views))
    }
  }
}

struct ConstrainedViews {
  var views: [String: AnyObject]! // key: {property: value}
  var formats: [String]! // NSLayoutConstraint.constraintsWithVisualFormat
}
