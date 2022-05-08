//
//  CalcViewController.swift
//  DaleChall
//
//  Created by Robert Linnemann on 5/5/22.
//

import UIKit

class CalcViewController: UIViewController {

  let titleLabel = UILabel()
  let inputField = UITextView()
  let calcButton = UIButton()
  //
  let detailLabel  = UILabel()
  var detailheightConstraint: NSLayoutConstraint?

  override func viewDidLoad() {
    addViews()
  }


  // MARK: View Setup
  func addViews() {
//    let contentView = createScrollView()
    //
    self.view.addSubview(titleLabel)
    self.view.addSubview(inputField)
    self.view.addSubview(detailLabel)
    self.view.addSubview(calcButton)
    //
    titleLabel.font = .preferredFont(forTextStyle: .headline)
    titleLabel.accessibilityTraits.insert(.header)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo:  self.view.leadingAnchor, constant: padding).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor, constant: -padding).isActive = true
    titleLabel.textAlignment = .center
    //
    inputField.font = .preferredFont(forTextStyle: .body)
    inputField.adjustsFontForContentSizeCategory = true
    inputField.translatesAutoresizingMaskIntoConstraints = false
    inputField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding).isActive = true
    inputField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding).isActive = true
    inputField.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor, constant: -padding).isActive = true
    inputField.layer.borderColor = UIColor.lightGray.cgColor
    inputField.layer.borderWidth = 1.0
    inputField.layer.cornerRadius = 8
    inputField.isEditable = true
    //
    detailLabel.translatesAutoresizingMaskIntoConstraints = false
    detailLabel.adjustsFontForContentSizeCategory = true
    detailLabel.numberOfLines = 0
    detailLabel.textAlignment = .center
    detailLabel.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: padding).isActive = true
    detailheightConstraint = detailLabel.heightAnchor.constraint(equalToConstant: 0.0)
    detailheightConstraint?.isActive = true
    detailLabel.leadingAnchor.constraint(equalTo:  self.view.leadingAnchor, constant: padding).isActive = true
    detailLabel.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor, constant: -padding).isActive = true
    //detailLabel.bottomAnchor.constraint(equalTo:  calcButton.bottomAnchor, constant: -padding).isActive = true
    //
    calcButton.accessibilityTraits = .button
    calcButton.titleLabel?.adjustsFontForContentSizeCategory = true
    calcButton.translatesAutoresizingMaskIntoConstraints = false
    calcButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: padding).isActive = true
    calcButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    calcButton.leadingAnchor.constraint(equalTo:  self.view.leadingAnchor, constant: padding).isActive = true
    calcButton.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor, constant: -padding).isActive = true
    calcButton.bottomAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.bottomAnchor, constant: -padding - 10).isActive = true
    calcButton.setTitleColor(.systemBlue, for: .normal)
    //
    titleLabel.text = "Calculate Score"
    inputField.accessibilityLabel = "Put in text to calculate score"
    // inputField.placeholder = "paste in text to calculate score"
    calcButton.setTitle("Calculate Score", for: .normal)
    calcButton.addTarget(self, action: #selector(calculateScore), for: .touchUpInside)
    detailLabel.text = ""
    // image of formula.
    // score

    // all in a scrollview
  }

  func showCalcDetail(_ show: Bool) {
    detailheightConstraint?.constant = show ? 44.0 : 0.0
  }

  // MARK: A11y specific

  override func accessibilityPerformMagicTap() -> Bool {
    calculateScore()
    return true
  }

  // MARK: Actions

  @objc func calculateScore() {
    guard inputField.text.isEmpty == false
    else {
      detailLabel.text = ""
      return
    }
    // then focus on detail, or announce
    let dcLevel = DaleChallCalc.check(self.inputField.text)
    let message = "\(dcLevel.gradeLevel()) \(dcLevel.difficulty())"
    detailLabel.text = message
    showCalcDetail(true)
    UIAccessibility.post(notification: .screenChanged, argument: message)
  }

}

extension CalcViewController: UITextViewDelegate {
  func textViewDidEndEditing(_ textView: UITextView) {
    print("didEndEditing")
  }
}
