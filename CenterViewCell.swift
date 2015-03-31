//
//  CenterViewCell.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/29/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class CenterViewCell: UITableViewCell {
  let innerView = UIView()

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = AppColors.Clear
    innerView.backgroundColor = UIColor.whiteColor()
    contentView.addSubview(innerView)
    innerView.setTranslatesAutoresizingMaskIntoConstraints(false)
    let constraintViews:[String: UIView] = ["innerView": innerView]
    let constraintFormats:[String] = [
      "H:|-5-[innerView]-5-|",
      "V:|-5-[innerView]-5-|",
    ]
    for format in constraintFormats {
      contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: .AlignAllLeft, metrics: nil, views: constraintViews))
    }
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func setupViews(contentViews: ContentViews) {
    for (id, subView) in contentViews.views {
      if let label = subView as? UILabel {
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = bounds.size.width - 40
      }
      innerView.addSubview(subView)
      subView.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    for format in contentViews.formats {
      innerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: .AlignAllLeft, metrics: nil, views: contentViews.views))
    }
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}