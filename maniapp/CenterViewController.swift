//
//  CenterViewController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/25/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class CenterViewController: UITableViewController {
  lazy var searchBar = UISearchBar()
  let cellIdentifier = "Cell"
  let headerFooterHight:CGFloat = 4

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = AppColors.Gray
    tableView?.separatorStyle = .None
    tableView?.registerClass(CenterViewCell.self, forCellReuseIdentifier: cellIdentifier)
    tableView?.estimatedRowHeight = 68
    tableView?.rowHeight = UITableViewAutomaticDimension
    tableView?.tableHeaderView = UIView(frame: CGRectMake(0, 0, headerFooterHight, headerFooterHight))
    tableView?.tableFooterView = UIView(frame: CGRectMake(0, 0, headerFooterHight, headerFooterHight))
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
    searchBar.setImage(UIImage(named: "search2.png"), forSearchBarIcon: UISearchBarIcon.Search, state: UIControlState.Normal)
    searchBar.setImage(UIImage(named: "clear.png"), forSearchBarIcon: UISearchBarIcon.Clear, state: UIControlState.Normal)
    let searchField = searchBar.valueForKey("searchField") as UITextField
    searchField.textColor = AppColors.White
    searchField.attributedPlaceholder = NSAttributedString(string:searchField.placeholder!, attributes: [NSForegroundColorAttributeName: AppColors.White])
    searchBar.frame = CGRectMake(0, 0, view.frame.maxX * 0.78, 20) // FIXME any better way to adjust the width?
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView:searchBar)
  }

  func handleHideOnSwipe(recognizer: UISwipeGestureRecognizer) {
    // hide the status bar for up swipes, show it for down swipes
    UIApplication.sharedApplication().setStatusBarHidden(navigationController!.navigationBar.frame.minY < -headerFooterHight, withAnimation: .Fade)
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cells.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as CenterViewCell
    cell.innerView.addConstrainedViews(cells[indexPath.row])
    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.cellForRowAtIndexPath(indexPath) as CenterViewCell
    Animations.bloat(cell.innerView)
    if (cell.cellState == .Collapsed) {
      (cell.innerView.viewWithTag(99) as UILabel).text = "open\nopen"
      cell.cellState = .Expanded
    } else if (cell.cellState == .Expanded) {
      (cell.innerView.viewWithTag(99) as UILabel).text = "close"
      cell.cellState = .Collapsed
    }
    //tableView.beginUpdates()
    //tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    //tableView.endUpdates()
    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
    navigationController!.navigationBarHidden = true
    // FIXME This does not work, why? tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    tableView.setContentOffset(CGPointMake(0, tableView.rectForRowAtIndexPath(indexPath).minY - headerFooterHight), animated: true)
  }
}