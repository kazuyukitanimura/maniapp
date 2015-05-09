//
//  PhotoController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 5/2/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  var imagePicker: UIImagePickerController!

  override func viewDidLoad() {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
      imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .PhotoLibrary
    }
  }

  func presentViewController(completion: (() -> Void)?) {
    presentViewController(imagePicker, animated: true, completion: completion)
    UIApplication.sharedApplication().statusBarStyle = .LightContent
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    Models.REALM.transactionWithBlock({ () -> Void in
      Models.getDraftMe().photo = UIImageJPEGRepresentation(image, 1.0)
    })
    imagePickerControllerDidCancel(picker)
  }

  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: view.removeFromSuperview)
    removeFromParentViewController()
  }
}