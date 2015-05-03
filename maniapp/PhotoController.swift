//
//  PhotoController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 5/2/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class PhotoController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  init() {
    super.init(nibName: nil, bundle: nil)
    delegate = self
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
      sourceType = .PhotoLibrary
      presentViewController(self, animated: true, completion: nil)
    }
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    println(image)
    picker.dismissViewControllerAnimated(true, completion: nil)
  }

  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
}