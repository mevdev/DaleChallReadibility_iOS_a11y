//
//  TabViewController.swift
//  DaleChall
//
//  Created by Robert Linnemann on 5/4/22.
//

import UIKit

class TabViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    self.setupTabs()
  }

  func setupTabs() {
    self.view.backgroundColor = .white
    let tabInfo = InfoViewController()
    let tabInfoBarItem = UITabBarItem(title: "Info", image: UIImage(systemName: "info.circle"), selectedImage: UIImage(systemName: "info.circle.fill"))
    tabInfo.tabBarItem = tabInfoBarItem

    let navController = UINavigationController()
    let tabSearch = SearchViewController()
    navController.viewControllers = [tabSearch]
    navController.isNavigationBarHidden = true

    let tabSearchBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "doc.text.magnifyingglass"), selectedImage: nil)
    tabSearch.tabBarItem = tabSearchBarItem


    let tabCalc = CalcViewController()
    let tabCalcBarItem = UITabBarItem(title: "Calculate", image: UIImage(systemName: "books.vertical.circle"), selectedImage: UIImage(systemName: "books.vertical.circle.fill"))
    tabCalc.tabBarItem = tabCalcBarItem

    self.viewControllers = [tabInfo, navController, tabCalc]
  }

}

extension TabViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    print("did select")
  }

}
