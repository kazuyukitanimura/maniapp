//
//  ProfileViewController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/6/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit
import AudioToolbox

protocol ProfileViewControllerDelegate {
  func saved(indexPath: NSIndexPath)
  func drafted(indexPath: NSIndexPath)
  func canceled(indexPath: NSIndexPath)
}

class ProfileViewController: UIViewController, AppButtonDelegate, UITextFieldDelegate {
  let labelFont = UIFont.boldSystemFontOfSize(13.0)
  let textFont = UIFont.systemFontOfSize(13.0)
  var delegate: ProfileViewControllerDelegate?
  var indexPath: NSIndexPath?
  // field ids
  let firstName = "firstName"
  let lastName = "lastName"
  let currentAffiliation = "currentAffiliation"
  let currentTitle = "currentTitle"

  init (delegate: ProfileViewControllerDelegate, indexPath: NSIndexPath) {
    super.init(nibName: nil, bundle: nil)
    self.delegate = delegate
    self.indexPath = indexPath
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    parentViewController?.addChildViewController(self)
    didMoveToParentViewController(parentViewController)
    view.backgroundColor = AppColors.Clear
    let profiles = Profile.allObjects()
    var me: Profile
    if (profiles.count == 0) {
      me = Profile()
      REALM.transactionWithBlock({ () -> Void in
        REALM.addObject(me)
      })
    } else {
      me = profiles[0] as! Profile
    }
    var profileFields = ConstrainedViews(views: [
      "firstNameLabel": [
        "text": "First",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      firstName: [
        "placeholder": "First name",
        "text": me.firstName,
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "lastNameLabel": [
        "text": "Last",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      lastName: [
        "placeholder": "Last name",
        "text": me.lastName,
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "currentAffiliationLabel": [
        "text": "Affiliation",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      currentAffiliation: [
        "placeholder": "Current affiliation",
        "text": me.currentAffiliation,
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "currentTitleLabel": [
        "text": "Job Title",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      currentTitle: [
        "placeholder": "Current title",
        "text": me.currentTitle,
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "currentLocationLabel": [
        "text": "Your location",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      "currentLocation": [
        "placeholder": "Current location",
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "willingToRelocateLabel": [
        "text": "Willing to relocate?",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      "willingToRelocate": [
        "placeholder": "Yes / No",
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "minCashComensationLabel": [
        "text": "Min cash compensation",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      "minCashComensation": [
        "placeholder": "(inc. bonus) for a new job",
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "minEquityComensationLabel": [
        "text": "Min equity compensation",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      "minEquityComensation": [
        "placeholder": "(X %) for a new job",
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "targetCompanySizeLabel": [
        "text": "Target company size",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      "targetCompanySize": [
        "placeholder": "Number of employees",
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "thankYouTipLabel": [
        "text": "Thank you tip $ amount",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      "thankYouTip": [
        "placeholder": "When I get a new job",
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "githubLabel": [
        "text": "Github URL",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      "github": [
        "placeholder": "Show your work",
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "blogLabel": [
        "text": "Blog URL",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      "blog": [
        "placeholder": "Talk about yourself",
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "skillsLabel": [
        "text": "Skills",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      "skills": [
        "placeholder": "Be specific!",
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "lookingForLabel": [
        "text": "Looking for ...",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      "lookingFor": [
        "placeholder": "Your objectives",
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "dreamCompaniesLabel": [
        "text": "Dream companies",
        "font": labelFont,
        "textColor": AppColors.Orange,
      ],
      "dreamCompanies": [
        "placeholder": "Company names",
        "font": textFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "save": SaveButton(delegate: self),
      "draft": DraftButton(delegate: self),
      "cancel": CancelButton(delegate: self),
      ], formats: [
        "H:|-0-[firstNameLabel]-(>=8)-[\(firstName)(>=160)]-0-|",
        "H:|-0-[lastNameLabel]-(>=8)-[\(lastName)(>=160)]-0-|",
        "H:|-0-[currentAffiliationLabel]-(>=8)-[\(currentAffiliation)(>=160)]-0-|",
        "H:|-0-[currentTitleLabel]-(>=8)-[\(currentTitle)(>=160)]-0-|",
        "H:|-0-[currentLocationLabel]-(>=8)-[currentLocation(>=160)]-0-|",
        "H:|-0-[willingToRelocateLabel]-(>=8)-[willingToRelocate(>=160)]-0-|",
        "H:|-0-[minCashComensationLabel]-(>=8)-[minCashComensation(>=160)]-0-|",
        "H:|-0-[minEquityComensationLabel]-(>=8)-[minEquityComensation(>=160)]-0-|",
        "H:|-0-[targetCompanySizeLabel]-(>=8)-[targetCompanySize(>=160)]-0-|",
        "H:|-0-[thankYouTipLabel]-(>=8)-[thankYouTip(>=160)]-0-|",
        "H:|-0-[githubLabel]-(>=8)-[github(>=160)]-0-|",
        "H:|-0-[blogLabel]-(>=8)-[blog(>=160)]-0-|",
        "H:|-0-[skillsLabel]-(>=8)-[skills(>=160)]-0-|",
        "H:|-0-[lookingForLabel]-(>=8)-[lookingFor(>=160)]-0-|",
        "H:|-0-[dreamCompaniesLabel]-(>=8)-[dreamCompanies(>=160)]-0-|",
        "H:|-0-[save(72)]-(>=8)-[draft(128)]-8-[cancel(80)]-0-|",
        "V:|-16-[firstNameLabel]-8-[lastNameLabel]-24-[currentAffiliationLabel]-8-[currentTitleLabel]-8-[currentLocationLabel]-24-[willingToRelocateLabel]-8-[minCashComensationLabel]-8-[minEquityComensationLabel]-8-[targetCompanySizeLabel]-8-[thankYouTipLabel]-24-[githubLabel]-8-[blogLabel]-8-[skillsLabel]-8-[lookingForLabel]-8-[dreamCompaniesLabel]-24-[save]-(>=8)-|",
        "V:|-16-[firstNameLabel]-8-[lastNameLabel]-24-[currentAffiliationLabel]-8-[currentTitleLabel]-8-[currentLocationLabel]-24-[willingToRelocateLabel]-8-[minCashComensationLabel]-8-[minEquityComensationLabel]-8-[targetCompanySizeLabel]-8-[thankYouTipLabel]-24-[githubLabel]-8-[blogLabel]-8-[skillsLabel]-8-[lookingForLabel]-8-[dreamCompaniesLabel]-24-[draft]-(>=8)-|",
        "V:|-16-[firstNameLabel]-8-[lastNameLabel]-24-[currentAffiliationLabel]-8-[currentTitleLabel]-8-[currentLocationLabel]-24-[willingToRelocateLabel]-8-[minCashComensationLabel]-8-[minEquityComensationLabel]-8-[targetCompanySizeLabel]-8-[thankYouTipLabel]-24-[githubLabel]-8-[blogLabel]-8-[skillsLabel]-8-[lookingForLabel]-8-[dreamCompaniesLabel]-24-[cancel]-(>=8)-|",
        "V:|-16-[\(firstName)]-8-[\(lastName)]-24-[\(currentAffiliation)]-8-[\(currentTitle)]-8-[currentLocation]-24-[willingToRelocate]-8-[minCashComensation]-8-[minEquityComensation]-8-[targetCompanySize]-8-[thankYouTip]-24-[github]-8-[blog]-8-[skills]-8-[lookingFor]-8-[dreamCompanies]-24-[save]-(>=8)-|",
        "V:|-16-[\(firstName)]-8-[\(lastName)]-24-[\(currentAffiliation)]-8-[\(currentTitle)]-8-[currentLocation]-24-[willingToRelocate]-8-[minCashComensation]-8-[minEquityComensation]-8-[targetCompanySize]-8-[thankYouTip]-24-[github]-8-[blog]-8-[skills]-8-[lookingFor]-8-[dreamCompanies]-24-[draft]-(>=8)-|",
        "V:|-16-[\(firstName)]-8-[\(lastName)]-24-[\(currentAffiliation)]-8-[\(currentTitle)]-8-[currentLocation]-24-[willingToRelocate]-8-[minCashComensation]-8-[minEquityComensation]-8-[targetCompanySize]-8-[thankYouTip]-24-[github]-8-[blog]-8-[skills]-8-[lookingFor]-8-[dreamCompanies]-24-[cancel]-(>=8)-|",
      ])
    view.addConstrainedViews(profileFields)
  }

  // hide keyboard when it lost focus
  // http://stackoverflow.com/questions/24908966/hide-keyboard-for-text-field-in-swift-programming-language
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    view.endEditing(true)
  }

  // move next text field or hide keyboard when return is pressed
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if let nextField = textField.getNextSiblingView() {
      nextField.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    return false // We do not want UITextField to insert line-breaks
  }

  func vibrrate() {
    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
      AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    })
  }

  func save(published: Bool) {
    REALM.transactionWithBlock({ () -> Void in
      let profiles = Profile.allObjects()
      let me = profiles[0] as! Profile
      me.firstName = (self.view.viewWithConstrainedViewID(self.firstName) as! UITextField).text.trim()
      me.lastName = (self.view.viewWithConstrainedViewID(self.lastName) as! UITextField).text.trim()
      me.currentAffiliation = (self.view.viewWithConstrainedViewID(self.currentAffiliation) as! UITextField).text.trim()
      me.currentTitle = (self.view.viewWithConstrainedViewID(self.currentTitle) as! UITextField).text.trim()
      me.published = published
    })
  }
  func saved() {
    vibrrate()
    delegate?.saved(indexPath!)
  }
  func drafted() {
    delegate?.drafted(indexPath!)
  }
  func canceled() {
    delegate?.canceled(indexPath!)
  }
}
