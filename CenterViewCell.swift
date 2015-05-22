//
//  CenterViewCell.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 3/29/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class CenterViewCell: UITableViewCell {
  let innerView = UIView()
  var indexPath: NSIndexPath?
  var delegate: ProfileViewControllerDelegate?

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = AppColors.Clear
    innerView.backgroundColor = AppColors.White
    innerView.layer.shadowOpacity = 0.1
    innerView.layer.shadowRadius = 1;
    innerView.layer.shadowOffset = CGSizeMake(0, 0);
    let constrainedViews = ConstrainedViews(views: ["innerView": innerView], formats:["H:|-\(AppPaddings.half)-[innerView]-\(AppPaddings.half)-|", "V:|-\(AppPaddings.quarter)-[innerView]-\(AppPaddings.quarter)-|"])
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

  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    super.touchesBegan(touches, withEvent: event)
    for touch in touches {
      if ((touch as! UITouch).locationInView(self.innerView).y < 100) {
        delegate?.drafted(indexPath!)
        break
      }
    }
  }
}