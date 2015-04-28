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
  case CenterView, MenuView
}

class ViewController: UIViewController, UIAlertViewDelegate, UIGestureRecognizerDelegate {
  var centerNavigationController: UINavigationController!
  lazy var centerViewController = CenterViewController()
  lazy var menuViewController = MenuViewController()
  lazy var loginViewController = LoginViewController()
  var currentState: ViewState = .CenterView
  let centerViewExpandedOffset: CGFloat = 60

  override func viewDidLoad() {
    super.viewDidLoad()
    Models.setup()
    NSNotificationCenter.defaultCenter().addObserver(self, selector:"applicationEnteredForeground:", name:"UIApplicationWillEnterForegroundNotification", object:nil)
    authenticateUser()
    UIApplication.sharedApplication().statusBarStyle = .LightContent
    centerViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu.png"), style: .Plain, target: self, action: "toggleMenuView")
    centerNavigationController = UINavigationController(rootViewController: centerViewController)
    view.insertSubview(centerNavigationController.view, atIndex: 1)
    addChildViewController(centerNavigationController)
    centerNavigationController.didMoveToParentViewController(self)
    centerNavigationController.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePanGesture:"))
    view.insertSubview(menuViewController.view, belowSubview: centerNavigationController.view)
    addChildViewController(menuViewController)
    menuViewController.didMoveToParentViewController(self)
    menuViewController.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePanGesture:"))
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
      animateCenterViewXPosition(targetPosition: -CGRectGetWidth(centerNavigationController.view.frame) + centerViewExpandedOffset)
    } else {
      animateCenterViewXPosition(targetPosition: 0) { _ in
        self.currentState = .CenterView
      }
    }
  }

  func animateCenterViewXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
    UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
      self.centerNavigationController.view.frame.origin.x = targetPosition
      }, completion: completion)
  }

  func handlePanGesture(recognizer: UIPanGestureRecognizer) {
    let targetView = centerNavigationController.view!
    if (recognizer.state == .Changed) {
      targetView.center.x = max(min(view.center.x, targetView.center.x + recognizer.translationInView(view).x), -view.center.x)
      recognizer.setTranslation(CGPointZero, inView: view)
    } else if (recognizer.state == .Ended) {
      let rightToLeft = recognizer.velocityInView(view).x < 0
      let lessThanQuarterway = targetView.center.x < -view.center.x / 2
      let greaterThanQuarterway = targetView.center.x < view.center.x / 2
      animateMenuView(shouldExpand: greaterThanQuarterway && (rightToLeft || lessThanQuarterway))
    }
  }

  func applicationEnteredForeground(notification: NSNotification) {
    authenticateUser()
  }

  func loadData() {
  }

  func showLoginView() {
    view.insertSubview(loginViewController.view, atIndex: 1000)
    addChildViewController(loginViewController)
    loginViewController.didMoveToParentViewController(self)
  }

  func authenticateUser() {
    if !loginViewController.isLoggedIn() {
      showLoginView()
      return
    }
    let context = LAContext()
    var error: NSError?
    var reasonString = "Use your fingerprint to login"
    context.localizedFallbackTitle = "" // hide the Enter Password Button
    if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
      context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in
        if success {
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.loadData()
          })
        } else {
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.showLoginView()
          })
        }
      })
    }
  }
}

