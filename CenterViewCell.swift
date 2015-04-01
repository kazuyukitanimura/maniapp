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

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = AppColors.Clear
    innerView.backgroundColor = UIColor.whiteColor()
    let constrainedViews = ConstrainedViews(views: ["innerView": innerView], formats:["H:|-8-[innerView]-8-|", "V:|-16-[innerView]-0-|"])
    contentView.addConstrainedViews(constrainedViews)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}