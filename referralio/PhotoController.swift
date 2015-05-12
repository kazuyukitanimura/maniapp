//
//  PhotoController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 5/2/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  var imagePicker: UIImagePickerController!
  var photoView: UIImageView?

  init(photoView: UIImageView?) {
    super.init(nibName: nil, bundle: nil)
    self.photoView = photoView
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
      imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .PhotoLibrary
    }
  }

  func presentViewController(completion: (() -> Void)?) {
    presentViewController(imagePicker, animated: true, completion: completion)
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    self.photoView?.image = image.resizeTo(160)
    imagePickerControllerDidCancel(picker)
  }

  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: { () -> Void in
      self.view.removeFromSuperview()
      self.removeFromParentViewController()
      UIApplication.sharedApplication().statusBarStyle = .LightContent
    })
  }
}