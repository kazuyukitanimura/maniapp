//
//  CenterViewCell.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/29/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class CenterViewCell: UITableViewCell {

  var nameLabel = UILabel()
  var addressLabel = UILabel()

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }

  func setupViews() {
    backgroundColor = AppColors.Clear

    nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    nameLabel.font = UIFont.boldSystemFontOfSize(16.0)
    nameLabel.numberOfLines = 0
    contentView.addSubview(nameLabel)

    addressLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    addressLabel.font = UIFont.systemFontOfSize(14.0)
    addressLabel.numberOfLines = 0
    addressLabel.preferredMaxLayoutWidth = bounds.size.width - 40;
    contentView.addSubview(addressLabel)

    let constraintViews:[String: UIView] = ["title": nameLabel, "body": addressLabel]
    let constraintFormats:[String] = [
      "H:|-5-[title]-5-|",
      "H:|-5-[body]-5-|",
      "V:|-5-[title]-5-[body]-(>=5)-|",
    ]
    for format in constraintFormats {
      contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: .AlignAllLeft, metrics: nil, views: constraintViews))
    }
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}