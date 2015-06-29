//
//  TutorialViewController.swift
//  referralio
//
//  Created by Kazuyuki Tanimura on 6/28/15.
//  Copyright (c) 2015 Kazuyuki Tanimura. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate {
  private var scrollView: UIScrollView!
  private var pageControl: UIPageControl!
  private let pageCount = 5
  private let scrollViewHeight:CGFloat = 160

  override func viewDidLoad() {
    super.viewDidLoad()
    var frame = view.bounds
    frame.size.height = scrollViewHeight
    scrollView = UIScrollView(frame: frame)
    scrollView.pagingEnabled = true
    scrollView.delegate = self
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.showsVerticalScrollIndicator = false
    pageControl = UIPageControl()
    pageControl.currentPage = 0
    pageControl.numberOfPages = pageCount

    let constrainedViews = ConstrainedViews(views: [
      "scrollView": scrollView,
      "pageControl": pageControl,
    ], formats:[
      "H:|-0-[scrollView]-0-|",
      "H:|-[pageControl]-|",
      "V:|-[scrollView(\(scrollView.bounds.height))]-[pageControl(8)]-|"
    ])
    view.addConstrainedViews(constrainedViews)

    for page in 0..<pageCount {
      var frame = scrollView.bounds
      frame.origin.x = frame.size.width * CGFloat(page)
      let newPageView = UILabel(frame: frame)
      newPageView.text = "Tutorial \(page + 1)"
      newPageView.textColor = AppColors.White
      newPageView.textAlignment = NSTextAlignment.Center
      scrollView.addSubview(newPageView)
    }

    let pagesScrollViewSize = scrollView.bounds.size
    scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageCount), pagesScrollViewSize.height)
  }

  func scrollViewDidScroll(scrollView: UIScrollView) {
    // Determine which page is currently visible, and update the page control
    let pageWidth = scrollView.frame.size.width
    pageControl.currentPage = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
  }
}
