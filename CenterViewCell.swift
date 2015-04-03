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
    innerView.backgroundColor = AppColors.White
    innerView.layer.shadowOpacity = 0.1
    innerView.layer.shadowRadius = 1;
    innerView.layer.shadowOffset = CGSizeMake(0, 1);
    let constrainedViews = ConstrainedViews(views: ["innerView": innerView], formats:["H:|-8-[innerView]-8-|", "V:|-4-[innerView]-4-|"])
    contentView.addConstrainedViews(constrainedViews)
    selectionStyle = .None
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}