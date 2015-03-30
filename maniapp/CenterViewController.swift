//
//  CenterViewController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/25/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class CenterViewController: UITableViewController {
  let profileImage = UIImage(named: "profile-rabbit-toy.png")
  let profileImageView = UIImageView()
  lazy var searchBar = UISearchBar()
  let cellIdentifier = "Cell"
  var hotels:[String: String] = ["The Grand Del Mar": "5300 Grand Del Mar Court, San Diego, CA 92130",
    "French Quarter Inn": "166 Church St, Charleston, SC 29401",
    "Bardessono": "6526 Yount Street, Yountville, CA 94599",
    "Hotel Yountville": "6462 Washington Street, Yountville, CA 94599",
    "Islington Hotel": "321 Davey Street, Hobart, Tasmania 7000, Australia",
    "The Henry Jones Art Hotel": "25 Hunter Street, Hobart, Tasmania 7000, Australia",
    "Clarion Hotel City Park Grand": "22 Tamar Street, Launceston, Tasmania 7250, Australia",
    "Quality Hotel Colonial Launceston": "31 Elizabeth St, Launceston, Tasmania 7250, Australia",
    "Premier Inn Swansea Waterfront": "Waterfront Development, Langdon Rd, Swansea SA1 8PL, Wales",
    "Hatcher's Manor": "73 Prossers Road, Richmond, Clarence, Tasmania 7025, Australia"]
  var hotelNames:[String] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = AppColors.White
    tableView?.separatorStyle = .None
    tableView?.registerClass(CenterViewCell.self, forCellReuseIdentifier: cellIdentifier)
    tableView?.estimatedRowHeight = 68
    tableView?.rowHeight = UITableViewAutomaticDimension
    profileImageView.image = profileImage
    profileImageView.frame = CGRectMake(0, 0, 100, 100)
    profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    profileImageView.clipsToBounds = true
    profileImageView.layer.position = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
    view.addSubview(profileImageView)

    hotelNames = [String](hotels.keys)
  }

  override func didMoveToParentViewController(parent: UIViewController?) {
    super.didMoveToParentViewController(parent)
    navigationController!.navigationBar.barTintColor = AppColors.Orange
    navigationController!.navigationBar.tintColor = AppColors.White
    navigationController!.hidesBarsOnSwipe = true
    navigationController!.barHideOnSwipeGestureRecognizer.addTarget(self, action: "handleHideOnSwipe:")
    searchBar.placeholder = "Search friends, updates, referrals"
    searchBar.tintColor = AppColors.White
    searchBar.searchBarStyle = .Minimal
    let searchField = searchBar.valueForKey("searchField") as UITextField
    searchField.textColor = AppColors.White
    searchField.attributedPlaceholder = NSAttributedString(string:searchField.placeholder!, attributes: [NSForegroundColorAttributeName: AppColors.White])
    searchBar.frame = CGRectMake(0, 0, view.frame.maxX * 0.77, 20) // FIXME any better way to adjust the width?
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView:searchBar)
  }

  func handleHideOnSwipe(recognizer: UISwipeGestureRecognizer) {
    // hide the status bar for up swipes, show it for down swipes
    UIApplication.sharedApplication().statusBarHidden = navigationController!.navigationBar.frame.minY < 0
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return hotels.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as CenterViewCell

    let hotelName = hotelNames[indexPath.row]
    cell.nameLabel.text = hotelName
    cell.addressLabel.text = hotels[hotelName]!

    return cell
  }
}