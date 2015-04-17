//
//  ConstrainedViews.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/2/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

extension UIView {
  func removeAllSubviews() {
    subviews.map { $0.removeFromSuperview() }
  }
  func addConstrainedViews(constrainedViews: ConstrainedViews) {
    var views = [String: UIView]()
    removeAllSubviews() // TODO take a diff instead of deleting all subviews
    for (id, viewObject) in constrainedViews.views {
      var subView: UIView
      if let viewSelf = viewObject as? UIView {
        subView = viewSelf
      } else {
        var viewProps = viewObject as! Dictionary<String, AnyObject>
        if let textProp = viewProps["placeholder"] as? String {
          subView = UITextField()
        } else if let textProp = viewProps["text"] as? String {
          subView = UILabel()
          (subView as! UILabel).numberOfLines = 0
        } else if let imageName = viewProps["image"] as? String {
          subView = UIImageView()
          viewProps["image"] = UIImage(named: imageName)
          if let frameRect = viewProps["frame"] as? NSValue {
            (subView as! UIImageView).frame = frameRect.CGRectValue()
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

enum CellState {
  case Collapsed, Expanded
}

class ConstrainedViews {
  typealias Views = [String: AnyObject]
  typealias Formats = [String]
  var views: Views! // key: {property: value}
  var formats: [String]! // NSLayoutConstraint.constraintsWithVisualFormat
  var state:CellState = CellState.Collapsed

  init(views: Views, formats: Formats) {
    self.views = views
    self.formats = formats
  }

  func updateViews(viewUpdates: Views) {
    for (id, viewObject) in viewUpdates {
      if let viewProps = viewObject as? Dictionary<String, AnyObject> {
        if let updatedView = views[id] as? UIView {
          updatedView.setValuesForKeysWithDictionary(viewProps)
        } else {
          var updatedViewProps = views[id] as! Dictionary<String, AnyObject>
          for (k, v) in viewProps {
            updatedViewProps[k] = v
          }
          views[id] = updatedViewProps
        }
      } else if let viewController = viewObject as? UIViewController {
        views[id] = viewController.view
      } else {
        views[id] = viewObject
      }
    }
  }
}