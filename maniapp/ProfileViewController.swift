//
//  ProfileViewController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/6/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = AppColors.Clear
    var profileFields = ConstrainedViews(views: [
      "firstName": [
        "placeholder": "First name",
      ],
      "lastName": [
        "placeholder": "Last name",
      ],
      "currentAffiliation": [
        "placeholder": "Current affiliation",
      ],
      "currentTitle": [
        "placeholder": "Current title",
      ],
      "currentLocation": [
        "placeholder": "Current location",
      ],
      "willingToRelocate": [
        "placeholder": "Willing to relocate",
      ],
      "minCashComensation": [
        "placeholder": "Min cash compensation (including bonus) to consider for a new job",
      ],
      "minEquityComensation": [
        "placeholder": "Min equity compensation (X %) to consider for a new job",
      ],
      "targetCompanySize": [
        "placeholder": "Target company size",
      ],
      "thankYouTip": [
        "placeholder": "Willing to pay $ if I get a new job",
      ],
      "github": [
        "placeholder": "Github",
      ],
      "blog": [
        "placeholder": "Blog",
      ],
      "skills": [
        "placeholder": "Skills",
      ],
      "lookingFor": [
        "placeholder": "Looking for...",
      ],
      "dreamCompanies": [
        "placeholder": "Dream companies",
      ],
      ], formats: [
        "H:|-8-[firstName]-8-|",
        "H:|-8-[lastName]-8-|",
        "H:|-8-[currentAffiliation]-8-|",
        "H:|-8-[currentTitle]-8-|",
        "H:|-8-[currentLocation]-8-|",
        "H:|-8-[willingToRelocate]-8-|",
        "H:|-8-[minCashComensation]-8-|",
        "H:|-8-[minEquityComensation]-8-|",
        "H:|-8-[targetCompanySize]-8-|",
        "H:|-8-[thankYouTip]-8-|",
        "H:|-8-[github]-8-|",
        "H:|-8-[blog]-8-|",
        "H:|-8-[skills]-8-|",
        "H:|-8-[lookingFor]-8-|",
        "H:|-8-[dreamCompanies]-8-|",
        "V:|-8-[firstName]-8-[lastName]-8-[currentAffiliation]-8-[currentTitle]-8-[currentLocation]-8-[willingToRelocate]-8-[minCashComensation]-8-[minEquityComensation]-8-[targetCompanySize]-8-[thankYouTip]-8-[github]-8-[blog]-8-[skills]-8-[lookingFor]-8-[dreamCompanies]-(>=8)-|",
      ])
    view.addConstrainedViews(profileFields)
  }
}
