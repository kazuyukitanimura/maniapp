//
//  CenterViewController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/25/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {
  let profileImage = UIImage(named: "profile-rabbit-toy.png")
  let profileImageView = UIImageView()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = AppColors.White
    profileImageView.image = profileImage
    profileImageView.frame = CGRectMake(0, 0, 100, 100)
    profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    profileImageView.clipsToBounds = true
    profileImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height/2)
    self.view.addSubview(profileImageView)
  }
}