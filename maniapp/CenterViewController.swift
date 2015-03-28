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
  lazy var searchBar = UISearchBar()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = AppColors.White
    profileImageView.image = profileImage
    profileImageView.frame = CGRectMake(0, 0, 100, 100)
    profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    profileImageView.clipsToBounds = true
    profileImageView.layer.position = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
    view.addSubview(profileImageView)
  }

  override func didMoveToParentViewController(parent: UIViewController?) {
    super.didMoveToParentViewController(parent)
    navigationController!.navigationBar.barTintColor = AppColors.Orange
    navigationController!.navigationBar.tintColor = AppColors.White
    navigationController!.hidesBarsOnSwipe = true
    searchBar.placeholder = "Search friends, updates, referrals"
    searchBar.tintColor = AppColors.White
    searchBar.searchBarStyle = .Minimal
    let searchField = searchBar.valueForKey("searchField") as UITextField
    searchField.textColor = AppColors.White
    searchField.attributedPlaceholder = NSAttributedString(string:searchField.placeholder!, attributes: [NSForegroundColorAttributeName: AppColors.White])
    searchBar.frame = CGRectMake(0, 0, view.frame.maxX - 80, 20) // TODO adjust the width
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView:searchBar)
  }
}