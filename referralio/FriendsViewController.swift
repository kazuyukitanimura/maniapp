//
//  FriendsViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 5/22/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class Friend: ConstrainedViews {
  init(profile: Profile) {
    super.init(views: [
      "title": [
        "text": "\(profile.firstName) \(profile.lastName)",
        "font": AppFonts.smallTitleFont,
        "textColor": AppColors.Orange,
      ],
      "subTitle": [
        "text": (profile.currentTitle.isEmpty || profile.currentAffiliation.isEmpty) ? "\(profile.currentTitle)\(profile.currentAffiliation)" : "\(profile.currentTitle) at \(profile.currentAffiliation)",
        "font": AppFonts.subTitleFont,
        "textColor": AppColors.DarkGray,
      ],
      "photo": [
        "image": profile.photo ?? "defaultProfile2.png",
        "frame": NSValue(CGRect: CGRectMake(0, 0, smallProfileSize, smallProfileSize)),
        "toCircle": true,
        "contentMode": UIViewContentMode.ScaleAspectFill.rawValue,
      ],
    ], formats: [
      "H:|-\(AppPaddings.half)-[photo(\(smallProfileSize))]-\(AppPaddings.one)-[title]-|",
      "H:|-\(AppPaddings.half)-[photo(\(smallProfileSize))]-\(AppPaddings.one)-[subTitle]-|",
      "V:|-\(AppPaddings.quarter + AppPaddings.halfQuarter)-[title]-\(AppPaddings.halfQuarter)-[subTitle]-(>=\(AppPaddings.quarter))-|",
      "V:|-\(AppPaddings.half)-[photo(\(smallProfileSize))]-(>=\(AppPaddings.half))-|",
    ])
  }
}

class FriendsViewController: PreviewViewController, AppButtonDelegate {
  private var page:UInt = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    // import contacts
    createList()
  }

  func createList() {
    let countPerPage:UInt = 5
    let countBase:UInt = 2
    var views = [String: AnyObject]()
    var formats = [String]()
    var vFormats = [String]()
    for i:UInt in (page * countPerPage + countBase)..<min((page + 1) * countPerPage + countBase, Models.count) {
      let key = "friend\(i)"
      views[key] = Friend(profile: Models.getProfile(i))
      formats.append("H:|-0-[\(key)]-0-|")
      vFormats.append("[\(key)]")
    }

    if (formats.count == 0) {
      // TODO no friends
      var alert = UIAlertController(title: "You have no friends!", message: "Login with Facebook to import firends", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      presentViewController(alert, animated: true, completion: nil)
      return
    }

    views["next"] = NextButton(delegate: self)
    if (Models.count <= (page + 1) * countPerPage + countBase) {
      (views["next"] as! NextButton).hidden = true
    }
    views["prev"] = PrevButton(delegate: self)
    if (page == 0) {
      (views["prev"] as! PrevButton).hidden = true
    }
    formats.append("H:|-0-[prev(80)]-(>=\(AppPaddings.one))-[next(80)]-0-|")
    formats.append("V:|-\(AppPaddings.half)-" + "-".join(vFormats) + "-[next]-\(AppPaddings.half)-|")
    formats.append("V:|-\(AppPaddings.half)-" + "-".join(vFormats) + "-[prev]-\(AppPaddings.half)-|")
    view.addConstrainedViews(ConstrainedViews(views: views, formats: formats))
  }

  func next() {
    page += 1
    createList()
  }

  func prev() {
    page -= 1
    createList()
  }

  func saved(){}
  func drafted(){}
  func canceled(){}
}
