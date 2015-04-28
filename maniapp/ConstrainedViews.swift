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
    constrainedViews.superview = self
    var views = [String: UIView]()
    removeAllSubviews() // TODO take a diff instead of deleting all subviews
    for (id, viewObject) in constrainedViews.views {
      var subView: UIView
      if let viewSelf = viewObject as? UIView {
        subView = viewSelf
      } else if let viewSelfController = viewObject as? UIViewController {
        subView = viewSelfController.view
      } else {
        var viewProps = viewObject as! Dictionary<String, AnyObject>
        if let textProp = viewProps["placeholder"] as? String {
          subView = UITextField()
          (subView as! UITextField).addTarget(self, action: "boldFont:", forControlEvents: .EditingChanged)
          if let keyboardType = viewProps["keyboardType"] as? Int {
            (subView as! UITextField).keyboardType = UIKeyboardType(rawValue: keyboardType)!
            viewProps.removeValueForKey("keyboardType")
          }
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
        subView.setValuesForKeysWithDictionary(viewProps)
      }
      subView.tag = ConstrainedViews.id2tag(id)
      addSubview(subView)
      subView.setTranslatesAutoresizingMaskIntoConstraints(false)
      views[id] = subView
    }
    for format in constrainedViews.formats {
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: nil, metrics: nil, views: views))
    }
  }

  func viewWithConstrainedViewID(id: String) -> UIView? {
    return viewWithTag(ConstrainedViews.id2tag(id))
  }

  func getNextSiblingView(ids: [String]?=nil) -> UIView? {
    if (ids != nil) {
      for (i, id) in enumerate(ids![0..<(ids!.count - 1)]) {
        if (tag == ConstrainedViews.id2tag(id)) {
          return superview?.viewWithConstrainedViewID(ids![i + 1])
        }
      }
    } else {
      let subviewsInType = superview?.subviews.filter({
        "\($0.dynamicType)" == "\(self.dynamicType)"
      }) as! [UIView]
      if let indexOfSelf = find(subviewsInType, self) {
        if (indexOfSelf < subviewsInType.count - 1) {
          return subviewsInType[indexOfSelf + 1]
        }
      }
    }
    return nil
  }

  func boldFont(sender: UITextField) {
    // TODO unbold when editted back
    sender.font = UIFont.boldSystemFontOfSize(sender.font.pointSize)
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
  var superview: UIView?

  init(views: Views, formats: Formats) {
    self.views = views
    self.formats = formats
  }

  func updateViews(viewUpdates: Views) {
    for (id, viewObject) in viewUpdates {
      if let viewProps = viewObject as? Dictionary<String, AnyObject> {
        if let updatedView = views[id] as? UIView {
          updatedView.setValuesForKeysWithDictionary(viewProps)
        } else if let updatedViewController = views[id] as? UIViewController {
          updatedViewController.view.setValuesForKeysWithDictionary(viewProps)
        } else {
          var updatedViewProps = views[id] as! Dictionary<String, AnyObject>
          for (k, v) in viewProps {
            updatedViewProps[k] = v
          }
          views[id] = updatedViewProps
        }
      } else {
        views[id] = viewObject
      }
    }
  }

  func viewWithConstrainedViewID(id: String) -> UIView? {
    return superview?.viewWithConstrainedViewID(id)
  }

  static func id2tag(id: String) -> Int{
    return id.hash // TODO is this ok?
  }
}