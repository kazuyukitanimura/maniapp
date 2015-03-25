//
//  ViewController.swift
//  maniapp
//
//  Created by Kazuyuki Tanimura on 3/22/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit
import LocalAuthentication

enum ViewState {
  case CenterView
  case MenuView
}

class ViewController: UIViewController, UIAlertViewDelegate, UIGestureRecognizerDelegate {
  var centerNavigationController: UINavigationController!
  var centerViewController = CenterViewController()
  var menuViewController = MenuViewController()
  var currentState: ViewState = .CenterView
  let centerViewExpandedOffset: CGFloat = 60

  override func viewDidLoad() {
    super.viewDidLoad()
    NSNotificationCenter.defaultCenter().addObserver(self, selector:"applicationEnteredForeground:", name:"UIApplicationWillEnterForegroundNotification", object:nil)
    authenticateUser()
    centerNavigationController = UINavigationController(rootViewController: centerViewController)
    view.addSubview(centerNavigationController.view)
    addChildViewController(centerNavigationController)
    centerNavigationController.didMoveToParentViewController(self)
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
    centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    centerViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: "toggleMenuView")
    view.insertSubview(menuViewController.view, atIndex: 0)
    addChildViewController(menuViewController)
    menuViewController.didMoveToParentViewController(self)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func toggleMenuView() {
    animateMenuView(shouldExpand: currentState != .MenuView)
  }

  func animateMenuView(#shouldExpand: Bool) {
    if (shouldExpand) {
      currentState = .MenuView
      UIApplication.sharedApplication().statusBarStyle = .LightContent
      animateCenterViewXPosition(targetPosition: -CGRectGetWidth(centerNavigationController.view.frame) + centerViewExpandedOffset)
    } else {
      animateCenterViewXPosition(targetPosition: 0) { _ in
        self.currentState = .CenterView
        UIApplication.sharedApplication().statusBarStyle = .Default
      }
    }
  }

  func animateCenterViewXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
      self.centerNavigationController.view.frame.origin.x = targetPosition
      }, completion: completion)
  }

  func handlePanGesture(recognizer: UIPanGestureRecognizer) {
    if (recognizer.state == .Changed) {
      recognizer.view!.center.x = min(view.center.x, recognizer.view!.center.x + recognizer.translationInView(view).x)
      recognizer.setTranslation(CGPointZero, inView: view)
    } else if (recognizer.state == .Ended) {
      let rightToLeft = recognizer.velocityInView(view).x < 0
      let lessThanQuarterway = recognizer.view!.center.x < -view.center.x / 2
      let greaterThanQuarterway = recognizer.view!.center.x < view.center.x / 2
      animateMenuView(shouldExpand: greaterThanQuarterway && (rightToLeft || lessThanQuarterway))
    }
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
    }
  }
}

