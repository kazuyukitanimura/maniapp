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
  let updatePhotoLabel = "updatePhotoLabel"
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
    var profileViews = [String:AnyObject]()
    profileViews["firstNameLabel"] = [
      "text": "First",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[firstName] = [
      "placeholder": "First name",
      "text": draftMe.firstName,
      "font": draftMe.firstName == me.firstName ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NamePhonePad.rawValue,
      "delegate": self,
    ]
    profileViews["lastNameLabel"] = [
      "text": "Last",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[lastName] = [
      "placeholder": "Last name",
      "text": draftMe.lastName,
      "font": draftMe.lastName == me.lastName ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NamePhonePad.rawValue,
      "delegate": self,
    ]
    profileViews["currentAffiliationLabel"] = [
      "text": "Affiliation",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[updatePhotoLabel] = [
      "image": (draftMe.photo.length > 0) ? draftMe.photo : "defaultProfile2.png",
      "frame": NSValue(CGRect: CGRectMake(0, 0, profileSize * 0.6, profileSize * 0.6)),
      "toCircle": true,
      "contentMode": UIViewContentMode.ScaleAspectFill.rawValue,
    ]
    profileViews["updatePhoto"] = UpdatePhotoButton(idOfPhoto: updatePhotoLabel)
    profileViews[currentAffiliation] = [
      "placeholder": "Current affiliation",
      "text": draftMe.currentAffiliation,
      "font": draftMe.currentAffiliation == me.currentAffiliation ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "delegate": self,
    ]
    profileViews["currentTitleLabel"] = [
      "text": "Job Title",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[currentTitle] = [
      "placeholder": "Current title",
      "text": draftMe.currentTitle,
      "font": draftMe.currentTitle == me.currentTitle ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "delegate": self,
    ]
    profileViews["currentLocationLabel"] = [
      "text": "Your location",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[currentLocation] = [
      "placeholder": "Current location",
      "text": draftMe.currentLocation,
      "font": draftMe.currentLocation == me.currentLocation ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "delegate": self,
    ]
    profileViews["willingToRelocateLabel"] = [
      "text": "Willing to relocate?",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[willingToRelocate] = [
      "placeholder": "Yes / No",
      "text": draftMe.willingToRelocate,
      "font": draftMe.willingToRelocate == me.willingToRelocate ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "delegate": self,
    ]
    profileViews["minCashComensationLabel"] = [
      "text": "Min cash compensation",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[minCashComensation] = [
      "placeholder": "(inc. bonus) for a new job",
      "text": draftMe.minCashComensation,
      "font": draftMe.minCashComensation == me.minCashComensation ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NumberPad.rawValue,
      "delegate": self,
    ]
    profileViews["minEquityComensationLabel"] = [
      "text": "Min equity compensation",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[minEquityComensation] = [
      "placeholder": "(X %) for a new job",
      "text": draftMe.minEquityComensation,
      "font": draftMe.minEquityComensation == me.minEquityComensation ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NumberPad.rawValue,
      "delegate": self,
    ]
    profileViews["targetCompanySizeLabel"] = [
      "text": "Target company size",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[targetCompanySize] = [
      "placeholder": "Number of employees",
      "text": draftMe.targetCompanySize,
      "font": draftMe.targetCompanySize == me.targetCompanySize ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NumberPad.rawValue,
      "delegate": self,
    ]
    profileViews["thankYouTipLabel"] = [
      "text": "Thank you tip $ amount",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[thankYouTip] = [
      "placeholder": "When I get a new job",
      "text": draftMe.thankYouTip,
      "font": draftMe.thankYouTip == me.thankYouTip ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NumberPad.rawValue,
      "delegate": self,
    ]
    profileViews["dreamCompaniesLabel"] = [
      "text": "Dream companies",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[dreamCompanies] = [
      "placeholder": "Comma separated",
      "text": draftMe.dreamCompanies,
      "font": draftMe.dreamCompanies == me.dreamCompanies ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "delegate": self,
    ]
    profileViews["lookingForLabel"] = [
      "text": "Objectives / Looking for",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[lookingFor] = [
      "placeholder": "Comma separated",
      "text": draftMe.lookingFor,
      "font": draftMe.lookingFor == me.lookingFor ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "delegate": self,
    ]
    profileViews["skillsLabel"] = [
      "text": "Skills",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[skills] = [
      "placeholder": "Comma separated",
      "text": draftMe.skills,
      "font": draftMe.skills == me.skills ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "delegate": self,
    ]
    profileViews["blogLabel"] = [
      "text": "Blog URL",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[blog] = [
      "placeholder": "Talk about yourself",
      "text": draftMe.blog,
      "font": draftMe.blog == me.blog ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.URL.rawValue,
      "delegate": self,
    ]
    profileViews["githubLabel"] = [
      "text": "Github URL",
      "font": boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[github] = [
      "placeholder": "Show your work",
      "text": draftMe.github,
      "font": draftMe.github == me.github ? normalFont : boldFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.URL.rawValue,
      "delegate": self,
    ]
    profileViews["save"] = SaveButton(delegate: self)
    profileViews["draft"] = DraftButton(delegate: self)
    profileViews["cancel"] = CancelButton(delegate: self)
    let profileFields = ConstrainedViews(views: profileViews, formats: [
      "H:|-0-[firstNameLabel]-(>=8)-[\(firstName)(>=160)]-0-|",
      "H:|-0-[lastNameLabel]-(>=8)-[\(lastName)(>=160)]-0-|",
      "H:|-0-[\(updatePhotoLabel)(\(profileSize * 0.6))]-(>=8)-[updatePhoto(>=160)]-0-|",
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
      "V:|-16-[firstNameLabel]-8-[lastNameLabel]-8-[\(updatePhotoLabel)(\(profileSize * 0.6))]-24-[currentAffiliationLabel]-8-[currentTitleLabel]-8-[currentLocationLabel]-24-[willingToRelocateLabel]-8-[minCashComensationLabel]-8-[minEquityComensationLabel]-8-[targetCompanySizeLabel]-8-[thankYouTipLabel]-24-[dreamCompaniesLabel]-8-[lookingForLabel]-8-[skillsLabel]-24-[blogLabel]-8-[githubLabel]-24-[save]-8-|",
      "V:|-(>=16)-[draft]-8-|",
      "V:|-16-[\(firstName)]-8-[\(lastName)]-8-[updatePhoto(\(profileSize * 0.6))]-24-[\(currentAffiliation)]-8-[\(currentTitle)]-8-[\(currentLocation)]-24-[\(willingToRelocate)]-8-[\(minCashComensation)]-8-[\(minEquityComensation)]-8-[\(targetCompanySize)]-8-[\(thankYouTip)]-24-[\(dreamCompanies)]-8-[\(lookingFor)]-8-[\(skills)]-24-[\(blog)]-8-[\(github)]-24-[cancel]-8-|",
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
      MultipleChoiceView(choices: ["Undecided", "Yes", "No"], textField: textField)
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

  func imageWithConstrainedViewID(id: String) -> UIImage {
    return (view.viewWithConstrainedViewID(id) as! UIImageView).image!
  }

  func save(profile: Profile) {
    Models.REALM.transactionWithBlock({ () -> Void in
      for id in self.ids {
        profile.setValue(self.stringWithConstrainedViewID(id), forKey: id)
      }
      profile.photo = UIImageJPEGRepresentation(self.imageWithConstrainedViewID(self.updatePhotoLabel), 1.0)
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
