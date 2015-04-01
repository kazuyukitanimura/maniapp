//
//  Cells.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/30/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

extension UIView {
  func addConstrainedViews(constrainedViews: ConstrainedViews) {
    for (id, constrainedView) in constrainedViews.views {
      if let constrainedLabel = constrainedView as? UILabel {
        constrainedLabel.numberOfLines = 0
        //constrainedLabel.preferredMaxLayoutWidth = bounds.size.width - 40
      }
      addSubview(constrainedView)
      constrainedView.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    for format in constrainedViews.formats {
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: .AlignAllLeft, metrics: nil, views: constrainedViews.views))
    }
  }
}

class ConstrainedView: UIView {
  convenience init(props: [String: String]) {
    self.init()
    for (propKey, propVal) in props {

    }
  }
}

struct ConstrainedViews {
  var views: [String: UIView]! // key: view
  var formats: [String]! // NSLayoutConstraint.constraintsWithVisualFormat
}

let cells:[ConstrainedViews] = [
  ConstrainedViews(views: ["profile": UILabel()], formats:["H:|-5-[profile]-5-|", "V:|-5-[profile]-5-|"]),
  ConstrainedViews(views: ["referral": UILabel()], formats:["H:|-5-[referral]-5-|", "V:|-5-[referral]-5-|"]),
  ConstrainedViews(views: ["notification": UILabel()], formats:["H:|-5-[notification]-5-|", "V:|-5-[notification]-5-|"]),
  ConstrainedViews(views: ["news": UILabel()], formats:["H:|-5-[news]-5-|", "V:|-5-[news]-5-|"]),
]