//
//  ProfileViewController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 4/6/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

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
  var backspace = false
  // field ids
  let firstName = "firstName"
  let lastName = "lastName"
  let currentAffiliation = "currentAffiliation"
  let currentTitle = "currentTitle"
  let currentLocation = "currentLocation"
  let willingToRelocate = "willingToRelocate"
  let minCashComensation = "minCashComensation"
  let minEquityComensation = "minEquityComensation"
  let targetCompanySize = "targetCompanySize"
  let thankYouTip = "thankYouTip"
  let dreamCompanies = "dreamCompanies"
  let lookingFor = "lookingFor"
  let skills = "skills"
  let blog = "blog"
  let github = "github"
  var ids: [String]!

  init(delegate: ProfileViewControllerDelegate, indexPath: NSIndexPath) {
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
    let me = Models.getMe()
    let draftMe = Models.getDraftMe()
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
        "keyboardType": UIKeyboardType.NamePhonePad.rawValue,
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
        "keyboardType": UIKeyboardType.NamePhonePad.rawValue,
        "delegate": self,
      ],
      "currentAffiliationLabel": [
        "text": "Affiliation",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      "updatePhoto": UpdatePhotoButton(),
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
      currentLocation: [
        "placeholder": "Current location",
        "text": draftMe.currentLocation,
        "font": draftMe.currentLocation == me.currentLocation ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "willingToRelocateLabel": [
        "text": "Willing to relocate?",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      willingToRelocate: [
        "placeholder": "Yes / No",
        "text": draftMe.willingToRelocate,
        "font": draftMe.willingToRelocate == me.willingToRelocate ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "minCashComensationLabel": [
        "text": "Min cash compensation",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      minCashComensation: [
        "placeholder": "(inc. bonus) for a new job",
        "text": draftMe.minCashComensation,
        "font": draftMe.minCashComensation == me.minCashComensation ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "keyboardType": UIKeyboardType.NumberPad.rawValue,
        "delegate": self,
      ],
      "minEquityComensationLabel": [
        "text": "Min equity compensation",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      minEquityComensation: [
        "placeholder": "(X %) for a new job",
        "text": draftMe.minEquityComensation,
        "font": draftMe.minEquityComensation == me.minEquityComensation ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "keyboardType": UIKeyboardType.NumberPad.rawValue,
        "delegate": self,
      ],
      "targetCompanySizeLabel": [
        "text": "Target company size",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      targetCompanySize: [
        "placeholder": "Number of employees",
        "text": draftMe.targetCompanySize,
        "font": draftMe.targetCompanySize == me.targetCompanySize ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "keyboardType": UIKeyboardType.NumberPad.rawValue,
        "delegate": self,
      ],
      "thankYouTipLabel": [
        "text": "Thank you tip $ amount",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      thankYouTip: [
        "placeholder": "When I get a new job",
        "text": draftMe.thankYouTip,
        "font": draftMe.thankYouTip == me.thankYouTip ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "keyboardType": UIKeyboardType.NumberPad.rawValue,
        "delegate": self,
      ],
      "dreamCompaniesLabel": [
        "text": "Dream companies",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      dreamCompanies: [
        "placeholder": "Comma separated",
        "text": draftMe.dreamCompanies,
        "font": draftMe.dreamCompanies == me.dreamCompanies ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "lookingForLabel": [
        "text": "Objectives / Looking for",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      lookingFor: [
        "placeholder": "Comma separated",
        "text": draftMe.lookingFor,
        "font": draftMe.lookingFor == me.lookingFor ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "skillsLabel": [
        "text": "Skills",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      skills: [
        "placeholder": "Comma separated",
        "text": draftMe.skills,
        "font": draftMe.skills == me.skills ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "delegate": self,
      ],
      "blogLabel": [
        "text": "Blog URL",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      blog: [
        "placeholder": "Talk about yourself",
        "text": draftMe.blog,
        "font": draftMe.blog == me.blog ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "keyboardType": UIKeyboardType.URL.rawValue,
        "delegate": self,
      ],
      "githubLabel": [
        "text": "Github URL",
        "font": boldFont,
        "textColor": AppColors.Orange,
      ],
      github: [
        "placeholder": "Show your work",
        "text": draftMe.github,
        "font": draftMe.github == me.github ? normalFont : boldFont,
        "textColor": AppColors.Black,
        "keyboardType": UIKeyboardType.URL.rawValue,
        "delegate": self,
      ],
      "save": SaveButton(delegate: self),
      "draft": DraftButton(delegate: self),
      "cancel": CancelButton(delegate: self),
      ], formats: [
        "H:|-0-[firstNameLabel]-(>=8)-[\(firstName)(>=160)]-0-|",
        "H:|-0-[lastNameLabel]-(>=8)-[\(lastName)(>=160)]-0-|",
        "H:|-0-[updatePhoto(>=160)]-(>=0)-|",
        "H:|-0-[currentAffiliationLabel]-(>=8)-[\(currentAffiliation)(>=160)]-0-|",
        "H:|-0-[currentTitleLabel]-(>=8)-[\(currentTitle)(>=160)]-0-|",
        "H:|-0-[currentLocationLabel]-(>=8)-[\(currentLocation)(>=160)]-0-|",
        "H:|-0-[willingToRelocateLabel]-(>=8)-[\(willingToRelocate)(>=160)]-0-|",
        "H:|-0-[minCashComensationLabel]-(>=8)-[\(minCashComensation)(>=160)]-0-|",
        "H:|-0-[minEquityComensationLabel]-(>=8)-[\(minEquityComensation)(>=160)]-0-|",
        "H:|-0-[targetCompanySizeLabel]-(>=8)-[\(targetCompanySize)(>=160)]-0-|",
        "H:|-0-[thankYouTipLabel]-(>=8)-[\(thankYouTip)(>=160)]-0-|",
        "H:|-0-[dreamCompaniesLabel]-(>=8)-[\(dreamCompanies)(>=160)]-0-|",
        "H:|-0-[lookingForLabel]-(>=8)-[\(lookingFor)(>=160)]-0-|",
        "H:|-0-[skillsLabel]-(>=8)-[\(skills)(>=160)]-0-|",
        "H:|-0-[blogLabel]-(>=8)-[\(blog)(>=160)]-0-|",
        "H:|-0-[githubLabel]-(>=8)-[\(github)(>=160)]-0-|",
        "H:|-0-[save(72)]-8-[draft(128)]-(>=8)-[cancel(80)]-0-|",
        "V:|-16-[firstNameLabel]-8-[lastNameLabel]-8-[updatePhoto]-24-[currentAffiliationLabel]-8-[currentTitleLabel]-8-[currentLocationLabel]-24-[willingToRelocateLabel]-8-[minCashComensationLabel]-8-[minEquityComensationLabel]-8-[targetCompanySizeLabel]-8-[thankYouTipLabel]-24-[dreamCompaniesLabel]-8-[lookingForLabel]-8-[skillsLabel]-24-[blogLabel]-8-[githubLabel]-24-[save]-8-|",
        "V:|-(>=16)-[draft]-8-|",
        "V:|-16-[\(firstName)]-8-[\(lastName)]-8-[updatePhoto]-24-[\(currentAffiliation)]-8-[\(currentTitle)]-8-[\(currentLocation)]-24-[\(willingToRelocate)]-8-[\(minCashComensation)]-8-[\(minEquityComensation)]-8-[\(targetCompanySize)]-8-[\(thankYouTip)]-24-[\(dreamCompanies)]-8-[\(lookingFor)]-8-[\(skills)]-24-[\(blog)]-8-[\(github)]-24-[cancel]-8-|",
      ])
    ids = [firstName, lastName, currentAffiliation, currentTitle, currentLocation, willingToRelocate, minCashComensation, minEquityComensation, targetCompanySize, thankYouTip, dreamCompanies, lookingFor, skills, blog, github]
    view.addConstrainedViews(profileFields, yield: { (subView: UIView) -> Void in
      if let textField = subView as? UITextField {
        if !textField.hasId(self.willingToRelocate) {
          textField.addTarget(self, action: "textFieldEditingChanged:", forControlEvents: .EditingChanged)
          textField.returnKeyType = textField.hasId(self.ids!.last!) ? .Done : .Next
        }
      }
    })
  }

  // hide keyboard when it lost focus
  // http://stackoverflow.com/questions/24908966/hide-keyboard-for-text-field-in-swift-programming-language
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    view.endEditing(true)
  }

  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    if textField.hasId(willingToRelocate) {
      MultipleChoiceView(choices: ["", "Yes", "No"], textField: textField)
    }
    return true
  }

  // move next text field or hide keyboard when return is pressed
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if let nextField = textField.getNextSiblingView(ids: ids) {
      nextField.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    return false // We do not want UITextField to insert line-breaks
  }

  // http://stackoverflow.com/questions/25371254/how-to-detect-delete-key-on-an-uitextfield-in-ios-8
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    // delete key is pressed
    backspace = (range.length==1 && string.length==0)
    return true
  }

  func textFieldEditingChanged(textField: UITextField) {
    textField.highlight() // TODO unhighlight when editted back
    let formatter = NSNumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    let digits = (textField.text.replace("[^\\.\\d]", with: "") ?? "")
    if (textField.hasId(minCashComensation) || textField.hasId(thankYouTip)) {
      formatter.numberStyle = .CurrencyStyle
      formatter.maximumIntegerDigits = 6
      textField.text = formatter.stringFromNumber(digits.toFloat())
    } else if textField.hasId(minEquityComensation) {
      formatter.numberStyle = .PercentStyle
      formatter.minimumFractionDigits = 3
      formatter.maximumFractionDigits = 3
      formatter.maximumIntegerDigits = 2
      textField.text = formatter.stringFromNumber(digits.toFloat() * (backspace ? 0.001 : 0.1))
    } else if textField.hasId(targetCompanySize) {
      formatter.numberStyle = .DecimalStyle
      formatter.maximumIntegerDigits = 8
      textField.text = formatter.stringFromNumber(digits.toFloat() * (backspace ? 0.1 : 1))
      if (textField.text.length > 0) {
        textField.text = textField.text + " Employees"
      }
    }
  }

  func stringWithConstrainedViewID(id: String) -> String {
    return (view.viewWithConstrainedViewID(id) as! UITextField).text.trim()
  }

  func save(profile: Profile) {
    Models.REALM.transactionWithBlock({ () -> Void in
      for id in self.ids {
        profile.setValue(self.stringWithConstrainedViewID(id), forKey: id)
      }
    })
  }
  func saved() {
    Vibrrate()
    delegate?.saved(indexPath!)
  }
  func drafted() {
    delegate?.drafted(indexPath!)
  }
  func canceled() {
    for id in ids {
      if view.viewWithConstrainedViewID(id)!.resignFirstResponder() {
        return
      }
    }
    delegate?.canceled(indexPath!)
  }
}
