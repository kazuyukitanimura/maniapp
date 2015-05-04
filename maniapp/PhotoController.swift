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

  func presentViewController() {
    presentViewController(imagePicker, animated: true, completion: nil)
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    println(image)
    picker.dismissViewControllerAnimated(true, completion: nil)
  }

  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
}