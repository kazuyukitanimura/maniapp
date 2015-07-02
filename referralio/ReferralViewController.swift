//
//  ReferralViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 5/19/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class ReferralViewController: PreviewViewController {
  let name = "name"
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

  override func viewDidLoad() {
    super.viewDidLoad()
    let referee = Models.getProfile(3) // TODO change to user id
    var profileViews = [String:AnyObject]()
    profileViews["nameLabel"] = [
      "text": "Name",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[name] = [
      "placeholder": "Name",
      "text": "*** (Hidden)",
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NamePhonePad.rawValue,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["currentAffiliationLabel"] = [
      "text": "Affiliation",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[currentAffiliation] = [
      "placeholder": "Current affiliation",
      "text": referee.currentAffiliation,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["currentTitleLabel"] = [
      "text": "Job Title",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[currentTitle] = [
      "placeholder": "Current title",
      "text": referee.currentTitle,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["currentLocationLabel"] = [
      "text": "Your location",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[currentLocation] = [
      "placeholder": "Current location",
      "text": referee.currentLocation,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["willingToRelocateLabel"] = [
      "text": "Willing to relocate?",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[willingToRelocate] = [
      "placeholder": "Yes / No",
      "text": referee.willingToRelocate,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NumberPad.rawValue, // fake
      "delegate": self,
      "enabled": false,
    ]
    profileViews["minCashComensationLabel"] = [
      "text": "Min cash compensation",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[minCashComensation] = [
      "placeholder": "(inc. bonus) for a new job",
      "text": referee.minCashComensation,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NumberPad.rawValue,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["minEquityComensationLabel"] = [
      "text": "Min equity compensation",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[minEquityComensation] = [
      "placeholder": "(X %) for a new job",
      "text": referee.minEquityComensation,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NumberPad.rawValue,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["targetCompanySizeLabel"] = [
      "text": "Target company size",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[targetCompanySize] = [
      "placeholder": "Number of employees",
      "text": referee.targetCompanySize,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NumberPad.rawValue,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["thankYouTipLabel"] = [
      "text": "Thank you tip $ amount",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[thankYouTip] = [
      "placeholder": "When I get a new job",
      "text": referee.thankYouTip,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.NumberPad.rawValue,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["dreamCompaniesLabel"] = [
      "text": "Dream companies",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[dreamCompanies] = [
      "placeholder": "Comma separated",
      "text": referee.dreamCompanies,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["lookingForLabel"] = [
      "text": "Objectives / Looking for",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[lookingFor] = [
      "placeholder": "Comma separated",
      "text": referee.lookingFor,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["skillsLabel"] = [
      "text": "Skills",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[skills] = [
      "placeholder": "Comma separated",
      "text": referee.skills,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["blogLabel"] = [
      "text": "Blog URL",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[blog] = [
      "placeholder": "Talk about yourself",
      "text": referee.blog,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.URL.rawValue,
      "delegate": self,
      "enabled": false,
    ]
    profileViews["githubLabel"] = [
      "text": "Github URL",
      "font": AppFonts.boldFont,
      "textColor": AppColors.Orange,
    ]
    profileViews[github] = [
      "placeholder": "Show your work",
      "text": referee.github,
      "font": AppFonts.normalFont,
      "textColor": AppColors.Black,
      "keyboardType": UIKeyboardType.URL.rawValue,
      "delegate": self,
      "enabled": false,
    ]
    let profileFields = ConstrainedViews(views: profileViews, formats: [
      "H:|-0-[nameLabel]-(>=\(AppPaddings.half))-[\(name)(>=160)]-0-|",
      "H:|-0-[currentAffiliationLabel]-(>=\(AppPaddings.half))-[\(currentAffiliation)(>=160)]-0-|",
      "H:|-0-[currentTitleLabel]-(>=\(AppPaddings.half))-[\(currentTitle)(>=160)]-0-|",
      "H:|-0-[currentLocationLabel]-(>=\(AppPaddings.half))-[\(currentLocation)(>=160)]-0-|",
      "H:|-0-[willingToRelocateLabel]-(>=\(AppPaddings.half))-[\(willingToRelocate)(>=160)]-0-|",
      "H:|-0-[minCashComensationLabel]-(>=\(AppPaddings.half))-[\(minCashComensation)(>=160)]-0-|",
      "H:|-0-[minEquityComensationLabel]-(>=\(AppPaddings.half))-[\(minEquityComensation)(>=160)]-0-|",
      "H:|-0-[targetCompanySizeLabel]-(>=\(AppPaddings.half))-[\(targetCompanySize)(>=160)]-0-|",
      "H:|-0-[thankYouTipLabel]-(>=\(AppPaddings.half))-[\(thankYouTip)(>=160)]-0-|",
      "H:|-0-[dreamCompaniesLabel]-(>=\(AppPaddings.half))-[\(dreamCompanies)(>=160)]-0-|",
      "H:|-0-[lookingForLabel]-(>=\(AppPaddings.half))-[\(lookingFor)(>=160)]-0-|",
      "H:|-0-[skillsLabel]-(>=\(AppPaddings.half))-[\(skills)(>=160)]-0-|",
      "H:|-0-[blogLabel]-(>=\(AppPaddings.half))-[\(blog)(>=160)]-0-|",
      "H:|-0-[githubLabel]-(>=\(AppPaddings.half))-[\(github)(>=160)]-0-|",
      "V:|-\(AppPaddings.one)-[nameLabel]-\(AppPaddings.oneHalf)-[currentAffiliationLabel]-\(AppPaddings.half)-[currentTitleLabel]-\(AppPaddings.half)-[currentLocationLabel]-\(AppPaddings.oneHalf)-[willingToRelocateLabel]-\(AppPaddings.half)-[minCashComensationLabel]-\(AppPaddings.half)-[minEquityComensationLabel]-\(AppPaddings.half)-[targetCompanySizeLabel]-\(AppPaddings.half)-[thankYouTipLabel]-\(AppPaddings.oneHalf)-[dreamCompaniesLabel]-\(AppPaddings.half)-[lookingForLabel]-\(AppPaddings.half)-[skillsLabel]-\(AppPaddings.oneHalf)-[blogLabel]-\(AppPaddings.half)-[githubLabel]-\(AppPaddings.half)-|",
      "V:|-\(AppPaddings.one)-[\(name)]-\(AppPaddings.oneHalf)-[\(currentAffiliation)]-\(AppPaddings.half)-[\(currentTitle)]-\(AppPaddings.half)-[\(currentLocation)]-\(AppPaddings.oneHalf)-[\(willingToRelocate)]-\(AppPaddings.half)-[\(minCashComensation)]-\(AppPaddings.half)-[\(minEquityComensation)]-\(AppPaddings.half)-[\(targetCompanySize)]-\(AppPaddings.half)-[\(thankYouTip)]-\(AppPaddings.oneHalf)-[\(dreamCompanies)]-\(AppPaddings.half)-[\(lookingFor)]-\(AppPaddings.half)-[\(skills)]-\(AppPaddings.oneHalf)-[\(blog)]-\(AppPaddings.half)-[\(github)]-\(AppPaddings.half)-|",
      ])
    view.addConstrainedViews(profileFields)
  }
}