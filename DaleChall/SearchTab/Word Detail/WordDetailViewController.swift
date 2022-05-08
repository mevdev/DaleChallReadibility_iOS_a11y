//
//  WordDetailViewController.swift
//  DaleChall
//
//  Created by Robert Linnemann on 5/7/22.
//

import UIKit

// show word and spinner, then fill in content.

class WordDetailViewController: UIViewController {

  let wordDetailViewModel: WordDetailViewModel
  let titleLabel = UILabel()

  init(wordDetailViewModel: WordDetailViewModel = WordDetailViewModel()) {
    self.wordDetailViewModel = wordDetailViewModel
    super.init(nibName: nil, bundle: nil)
    wordDetailViewModel.fetch { [weak self] success in
      if success == true {
      self?.renderDictionaryDetail()
      } else {
        self?.renderError()
      }
    }
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: View Layout


  override func viewDidLoad() {
    addViews()
    self.navigationController?.isNavigationBarHidden = false
    self.title = "Definition"
  }

  func addViews() {
    self.view.addSubview(titleLabel)
    titleLabel.font = .preferredFont(forTextStyle: .headline)
    titleLabel.accessibilityTraits.insert(.header)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: padding).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding).isActive = true
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .byWordWrapping

    titleLabel.text = self.wordDetailViewModel.word
  }

  func renderDictionaryDetail() {
    print("renderDictionaryDetail")
  }

  func renderError() {
    // say it wasn't in that dictionary (pull from token)
  }

  // MARK: A11y specific
  override func accessibilityPerformEscape() -> Bool {
    self.dismiss(animated: true)
    return true
  }

}

extension UIViewController {
  func createScrollView() -> UIView {
    let scrollView = UIScrollView()
    self.view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true

    let contentView = UIView()
    scrollView.addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    contentView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10.0).isActive = true

    return contentView
  }
}

