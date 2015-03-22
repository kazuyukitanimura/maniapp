//
//  ViewController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/22/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController, UIAlertViewDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    NSNotificationCenter.defaultCenter().addObserver(self, selector:"applicationEnteredForeground:", name:"UIApplicationWillEnterForegroundNotification", object:nil)
    authenticateUser()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func applicationEnteredForeground(notification: NSNotification) {
    authenticateUser()
  }

  func loadData() {

  }

  func showPasswordAlert() {
    var passwordAlert : UIAlertView = UIAlertView(title: "TouchIDDemo", message: "Please type your password", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Okay")
    passwordAlert.alertViewStyle = UIAlertViewStyle.SecureTextInput
    passwordAlert.show()
  }
  //http://www.ioscreator.com/tutorials/drawing-circles-uitouch-ios8-swift
  func authenticateUser() {
    let context = LAContext()
    var error: NSError?
    var reasonString = "Please log in"
    if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
      [context .evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in
        if success {
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.loadData()
          })
        } else {
          // If authentication failed then show a message to the console with a short description.
          // In case that the error is a user fallback, then show the password alert view.
          println(evalPolicyError?.localizedDescription)
          switch evalPolicyError!.code {
          case LAError.SystemCancel.rawValue:
            println("Authentication was cancelled by the system")
          case LAError.UserCancel.rawValue:
            println("Authentication was cancelled by the user")
          case LAError.UserFallback.rawValue:
            println("User selected to enter custom password")
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.showPasswordAlert()
            })
          default:
            println("Authentication failed")
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.showPasswordAlert()
            })
          }
        }
      })]
    } else {
      // If the security policy cannot be evaluated then show a short message depending on the error.
      println(error?.localizedDescription)
      switch error!.code{
      case LAError.TouchIDNotEnrolled.rawValue:
        println("TouchID is not enrolled")
      case LAError.PasscodeNotSet.rawValue:
        println("A passcode has not been set")
      default:
        // The LAError.TouchIDNotAvailable case.
        println("TouchID not available")
      }
      showPasswordAlert()
    }
  }

}

