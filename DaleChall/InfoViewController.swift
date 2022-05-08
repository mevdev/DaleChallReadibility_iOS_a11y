//
//  InfoViewController.swift
//  DaleChall
//
//  Created by Robert Linnemann on 5/5/22.
//

import UIKit

let padding: CGFloat = 10.0
class InfoViewController: UIViewController {

  override func viewDidLoad() {
    addViews()
  }

  func addViews() {
    
    let title = UILabel()
    self.view.addSubview(title)
    title.font = .preferredFont(forTextStyle: .headline)
    title.accessibilityTraits.insert(.header)
    title.adjustsFontForContentSizeCategory = true
    title.translatesAutoresizingMaskIntoConstraints = false
    title.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: padding).isActive = true
    title.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding).isActive = true
    title.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding).isActive = true
    title.textAlignment = .center
    title.numberOfLines = 0
    title.lineBreakMode = .byWordWrapping
    //
    let desc = UILabel()
    self.view.addSubview(desc)
    desc.font = .preferredFont(forTextStyle: .body)
    desc.adjustsFontForContentSizeCategory = true
    desc.translatesAutoresizingMaskIntoConstraints = false
    desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: padding).isActive = true
    desc.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding).isActive = true
    desc.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding).isActive = true
    desc.numberOfLines = 0
    desc.lineBreakMode = .byWordWrapping
    //
    title.text = "Dale-Chall Readability Formula"
    desc.text = "The formula was developed by Edgar Dale and Jeanne Chall and was originally published in their 1948 article 'A Formula for Predicting Readability' and then updated in 1995 in 'Readability Revisited: The New Dale-Chall Readability Formula. It gives a numeric score based on 3,000 familiar words."

    // image of formula.
    // score

    // all in a scrollview
  }

}
