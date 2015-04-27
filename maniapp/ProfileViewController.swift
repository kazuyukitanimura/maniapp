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
  let boldFont = UIFont.boldSystemFontOfSize(13.0)
  let normalFont = UIFont.systemFontOfSize(13.0)
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
    let me = GetMe()
    let draftMe = GetDraftMe()
    var profileFields = ConstrainedViews(views: [
      "firstNameLabel": [
        "text": "First",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      firstName: [
        "placeholder": "First name",
        "text": draftMe.firstName,
        "font": draftMe.firstName == me.firstName ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "lastNameLabel": [
        "text": "Last",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      lastName: [
        "placeholder": "Last name",
        "text": draftMe.lastName,
        "font": draftMe.lastName == me.lastName ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "currentAffiliationLabel": [
        "text": "Affiliation",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      currentAffiliation: [
        "placeholder": "Current affiliation",
        "text": draftMe.currentAffiliation,
        "font": draftMe.currentAffiliation == me.currentAffiliation ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "currentTitleLabel": [
        "text": "Job Title",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      currentTitle: [
        "placeholder": "Current title",
        "text": draftMe.currentTitle,
        "font": draftMe.currentTitle == me.currentTitle ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "currentLocationLabel": [
        "text": "Your location",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "currentLocation": [
        "placeholder": "Current location",
        "font": normalFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "willingToRelocateLabel": [
        "text": "Willing to relocate?",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "willingToRelocate": [
        "placeholder": "Yes / No",
        "font": normalFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "minCashComensationLabel": [
        "text": "Min cash compensation",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "minCashComensation": [
        "placeholder": "(inc. bonus) for a new job",
        "font": normalFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "minEquityComensationLabel": [
        "text": "Min equity compensation",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "minEquityComensation": [
        "placeholder": "(X %) for a new job",
        "font": normalFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "targetCompanySizeLabel": [
        "text": "Target company size",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "targetCompanySize": [
        "placeholder": "Number of employees",
        "font": normalFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "thankYouTipLabel": [
        "text": "Thank you tip $ amount",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "thankYouTip": [
        "placeholder": "When I get a new job",
        "font": normalFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "githubLabel": [
        "text": "Github URL",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "github": [
        "placeholder": "Show your work",
        "font": normalFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "blogLabel": [
        "text": "Blog URL",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "blog": [
        "placeholder": "Talk about yourself",
        "font": normalFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "skillsLabel": [
        "text": "Skills",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "skills": [
        "placeholder": "Be specific!",
        "font": normalFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "lookingForLabel": [
        "text": "Looking for ...",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "lookingFor": [
        "placeholder": "Your objectives",
        "font": normalFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "dreamCompaniesLabel": [
        "text": "Dream companies",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "dreamCompanies": [
        "placeholder": "Company names",
        "font": normalFont,
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
    let viewOrder = [firstName, lastName, currentAffiliation, currentTitle]
    if let nextField = textField.getNextSiblingView(viewOrder: viewOrder) {
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

  func stringWithConstrainedViewID(id: String) -> String {
    return (self.view.viewWithConstrainedViewID(id) as! UITextField).text.trim()
  }

  func save(profile: Profile) {
    REALM.transactionWithBlock({ () -> Void in
      profile.firstName = self.stringWithConstrainedViewID(self.firstName)
      profile.lastName = self.stringWithConstrainedViewID(self.lastName)
      profile.currentAffiliation = self.stringWithConstrainedViewID(self.currentAffiliation)
      profile.currentTitle = self.stringWithConstrainedViewID(self.currentTitle)
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
